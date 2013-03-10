do ->
  DownloadDialogue = -> """
  <a class="btn im-open-dialogue" href="#">
    <i class="#{ intermine.icons.Export }"></i>
    #{ intermine.messages.actions.ExportButton }
  </a>

  <div class="modal fade tabbable tabs-below">

    <div class="modal-header">
      <a href="#" class="close" data-dismiss="modal">close</a>
      <h2>
        #{ intermine.messages.actions.ExportTitle }
      </h2>
    </div>

    <div class="modal-body tab-content">
     <div class="carousel slide">
      <div class="carousel-inner">
      <div class="active item">
      <form class="form">

        <div class="row-fluid">
          <label>
            <span class="span4">
              #{ intermine.messages.actions.ExportFormat }
            </span>
            <select class="im-export-format input-xlarge span8"></select>
          </label>  
        </div>

        <div class="row-fluid im-column-selection">
          <label title="#{ intermine.messages.actions.ColumnsHelp }">
            <span class="span4">
              #{ intermine.messages.actions.WhichColumns }
            </span>
            <div class="im-col-btns radio btn-group pull-right span8">
              <button class="btn active im-all-cols span6">
                #{ intermine.messages.actions.AllColumns }
              </button>
              <button class="btn span5">
                #{ intermine.messages.actions.SomeColumns }
              </button>
            </div>
          </label>
          <div class="clearfix"></div>
          <div class="im-col-options">
            <div class="well">
              <ul class="im-cols im-exported-cols nav nav-tabs nav-stacked"></ul>
            </div>
            <h4>#{ intermine.messages.actions.PossibleColumns }</h4>
            <div class="im-can-be-exported-cols">
            </div>
            <div style="clear:both;"></div>
            <button class="im-reset-cols btn disabled">
              <i class="#{ intermine.icons.Undo }"></i>
              #{ intermine.messages.actions.ResetColumns }
            </button>
          </div>
        </div>

        <div class="row-fluid im-row-opts">
          <label title="#{ intermine.messages.actions.RowsHelp }">
            <span class="span4">
              #{ intermine.messages.actions.WhichRows }
            </span>
            <div class="im-row-btns radio span8 btn-group pull-right"
                  data-toggle="buttons-radio">
              <button class="btn active im-all-rows span6">
                #{ intermine.messages.actions.AllRows }
              </button>
              <button class="btn span5">
                #{ intermine.messages.actions.SomeRows }
              </button>
            </div>
          </label>
          <div class="form-horizontal">
            <fieldset class="im-row-selection control-group">
              <label class="control-label">
                #{ intermine.messages.actions.FirstRow }
                <input type="text" value="1"
                        class="disabled input-mini im-first-row im-range-limit">
              </label>
              <label class="control-label">
                #{ intermine.messages.actions.LastRow }
                <input type="text"
                        class="disabled input-mini im-last-row im-range-limit">
              </label>
              <div style="clear:both"></div>
              <div class="slider im-row-range-slider"></div>
            </fieldset>
          </div>
        </div>

        <fieldset class="control-group">
          <label>
            <span class="span4">
              #{ intermine.messages.actions.CompressResults }
            </span>
            <div class="span8 im-compression-opts radio btn-group pull-right"
                  data-toggle="buttons-radio">
              <button class="btn active im-no-compression span7">
                #{ intermine.messages.actions.NoCompression }
              </button>
              <button class="btn im-gzip-compression span2">
                #{ intermine.messages.actions.GZIPCompression }
              </button>
              <button class="btn im-zip-compression span2">
                #{ intermine.messages.actions.ZIPCompression }
              </button>
            </div>
          </label>
        </fieldset>

        <div class="row-fluid">
          <fieldset class="im-export-options control-group">
          </fieldset>
        </div>

      </form>
      
      </div> <!-- End item -->
      
      <div class="item">
        <iframe class="gs-frame" width="0" height="0" frameborder="0"
          id="im-to-gs-#{ new Date().getTime() }">
        </iframe>
      </div>

      </div> <!-- end inner -->
      </div> <!-- end carousel -->

      <div class="row-fluid im-export-destination-options">

        <div class="im-download-file active">
          <i class="icon icon-link im-copy"></i>
          <span class="hidden-phone">
            #{ intermine.messages.actions.ResultsPermaLinkText }
          </span>
          <i class="icon-angle-right im-collapser"></i>

          <div class="well im-perma-link-content hide"></div>

          <div class="alert alert-block im-private-query">
            <button type="button" class="close" data-dismiss="alert">×</button>
            <h4>nb:</h4>
            #{ intermine.messages.actions.IsPrivateData }
          </div>

        </div>

        <div class="im-galaxy">
          <form class="im-galaxy form form-compact well">
            <label>
              #{ intermine.messages.actions.GalaxyURILabel }
              <input class="im-galaxy-uri" 
                    type="text" value="#{ intermine.options.GalaxyMain }">
            </label>
            <label>
              #{ intermine.messages.actions.SaveGalaxyURL }
              <input type="checkbox" disabled checked class="im-galaxy-save-url">
            </label>
          </form>
        </div>

      </div>
    </div>

    <ul class="im-export-destinations nav nav-tabs">
      <li class="active">
        <a href="#" data-section="download-file">
          <i class="icon-paper-clip im-copy"></i>
          #{ intermine.messages.actions.ExportLong }
        </a>
      </li>
      <li>
        <a href="#" data-section="galaxy">
          #{ intermine.messages.actions.SendToGalaxy }
        </a>
      </li>
      <li>
        <a href="#" data-section="genomespace" >
          #{ intermine.messages.actions.SendToGenomespace }
        </a>
      </li>
    </ul>

    <div class="modal-footer">
      <a href="#" class="btn btn-primary im-download pull-right"
              title="#{ intermine.messages.actions.ExportHelp }">
        <i class="icon #{ intermine.icons.Export }"></i>
        #{ intermine.messages.actions.Export }
      </a>
      <button class="btn btn-cancel pull-left im-cancel">
        #{ intermine.messages.actions.Cancel }
      </button>
    </div>

  </div>
  """

  scope 'intermine.snippets.actions', {DownloadDialogue}
