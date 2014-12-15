_ = require 'underscore'
fs = require 'fs'

Messages = require '../messages'
Icons = require '../icons'
View = require '../core-view'

TypeValueControls = require './type-value-controls'
AttributeValueControls = require './attribute-value-controls'
MultiValueControls = require './multi-value-controls'
BooleanValueControls = require './boolean-value-controls'
LookupValueControls = require './lookup-value-controls'
LoopValueControls = require './loop-value-controls'
ListValueControls = require './list-value-controls'

{Query, Model} = require 'imjs'

# Operator sets
{REFERENCE_OPS, LIST_OPS, MULTIVALUE_OPS, NULL_OPS, ATTRIBUTE_OPS, ATTRIBUTE_VALUE_OPS} = Query
{NUMERIC_TYPES, BOOLEAN_TYPES} = Model

BASIC_OPS = ATTRIBUTE_VALUE_OPS.concat NULL_OPS

html = fs.readFileSync __dirname + '/../templates/constraint-editor.html', 'utf8'

TEMPLATE = _.template html, variable: 'data'
NO_OP = -> # A function that doesn't do anything

operatorsFor = (path) ->
  if path.isReference() or path.isRoot()
    REFERENCE_OPS
  else if path.getType() in BOOLEAN_TYPES
    ["=", "!="].concat(NULL_OPS)
  else
    ATTRIBUTE_OPS

module.exports = class ConstraintEditor extends View

  tagName: 'form'

  className: 'form'

  initialize: ({@query}) ->
    super
    @listenTo @model, 'change:op change:error', @reRender
    @path = @model.get 'path'
    @listenTo @model, 'change:error', @logError

  logError: ->
    if e = @model.get('error')
      console.error e, e.stack

  getType: -> @model.get('path').getType()

  events: ->
    'submit': (e) -> e.preventDefault(); e.stopPropagation()
    'click .btn-cancel': 'cancelEditing'
    'click .btn-primary': 'applyChanges'
    'change .im-ops': 'setOperator'

  setOperator: -> @model.set op: @$('.im-ops').val()

  cancelEditing: ->
    @model.trigger 'cancel'

  applyChanges: -> @model.trigger 'apply', @getConstraint()

  getConstraint: ->
    con = @model.pick ['path', 'op', 'value', 'values', 'code', 'type']

    if con.op in MULTIVALUE_OPS.concat(NULL_OPS)
      delete con.value
    
    if con.op in ATTRIBUTE_VALUE_OPS.concat(NULL_OPS)
      delete con.values

    return con

  # The main dispatch mechanism, delegates to sub-views that know 
  # how to handle different constraint types.
  # dispatches to one of 8 constraint sub-types.
  getValueControls: ->
    if @isNullConstraint()
      return null # Null child components are ignored.
    if @isTypeConstraint()
      return new TypeValueControls {@model, @query}
    if @isMultiValueConstraint()
      return new MultiValueControls {@model}
    if @isListConstraint()
      return new ListValueControls {@model, @query}
    if @isBooleanConstraint()
      return new BooleanValueControls {@model}
    if @isLoopConstraint()
      return new LoopValueControls {@model, @query}
    if @isLookupConstraint()
      return new LookupValueControls {@model}

    # By elimination, it must be one of these.
    return new AttributeValueControls {@model, @query}

  isNullConstraint: -> @model.get('op') in NULL_OPS

  isLoopConstraint: -> @path.isReference() and (@model.get('op') in ['=', '!='])

  isTypeConstraint: -> @path.isReference() and (not @model.get 'op') and @model.has('type')

  isBooleanConstraint: -> (@path.getType() in BOOLEAN_TYPES) and not (@model.get('op') in NULL_OPS)

  isMultiValueConstraint: -> @path.isAttribute() and (@model.get('op') in MULTIVALUE_OPS)

  isListConstraint: -> @path.isReference() and (@model.get('op') in LIST_OPS)

  isLookupConstraint: -> @path.isReference() and (@model.get('op') in TERNARY_OPS)

  # Will need adding, imminently.
  # isRangeConstraint: -> @path.isReference() and (@model.get('op') in RANGE_OPS)

  getOtherOperators: -> _.without operatorsFor(@model.get 'path'), @model.get 'op'

  buttons: -> [
      {
          key: "conbuilder.Update",
          classes: "btn btn-primary"
      },
      {
          key: "conbuilder.Cancel",
          classes: "btn btn-cancel"
      }
  ]

  getData: ->
    buttons = @buttons()
    messages = Messages
    icons = Icons
    otherOperators = @getOtherOperators()
    con = @model.toJSON()
    {buttons, icons, messages, icons, otherOperators, con}

  template: TEMPLATE

  render: ->
    super
    @renderChild 'valuecontrols', @getValueControls(), @$ '.im-value-options'
    this

  remove: -> # Animated removal
    @$el.slideUp always: => super()
