$ = require 'jquery'

Options = require 'imtables/options'

# Code under test:
TableModel      = require 'imtables/models/table'
SelectedObjects = require 'imtables/models/selected-objects'
CellModelFactory = require 'imtables/utils/cell-model-factory'
PopoverFactory   = require 'imtables/utils/popover-factory'
Preview     = require 'imtables/views/item-preview'

# Test helpers.
BasicTable = require '../lib/basic-table'
Toggles = require '../lib/toggles'
Label = require '../lib/label'
renderQueries = require '../lib/render-queries.coffee'
renderWithCounter = require '../lib/render-query-with-counter-and-displays'
{connection} = require '../lib/connect-to-service'

Options.set 'ModelDisplay.Initially.Closed', true
# Make these toggleable...
Options.set 'TableCell.PreviewTrigger', 'hover'
Options.set 'TableCell.IndicateOffHostLinks', false
Options.set 'TableResults.CacheFactor', 2

selectedObjects = new SelectedObjects connection
tableState = new TableModel

create = (query) ->
  new BasicTable
    model: tableState
    query: query
    popovers: (new PopoverFactory connection, Preview)
    modelFactory: (new CellModelFactory connection, query.model)
    selectedObjects: selectedObjects

QUERY =
  name: 'cell query'
  select: [
    'name',
    'employees.name',
    'employees.simpleObjects.name'
  ]
  from: 'Department'

toggles = [
  {attr: 'selecting', type: 'bool'},
  {attr: 'highlitNode', type: 'enum', opts: ['Department', 'Department.employees']}
]

renderQuery = renderWithCounter create, (->), ['model', 'rows']

$ ->
  toggles = new Toggles model: tableState, toggles: toggles
  commonTypeLabel = new Label
    model: selectedObjects
    attr: 'Common Type'
    getter: -> selectedObjects.state.get('commonType') if selectedObjects.length

  toggles.render().$el.appendTo 'body'
  commonTypeLabel.render().$el.appendTo 'body'

  renderQueries [QUERY], renderQuery
