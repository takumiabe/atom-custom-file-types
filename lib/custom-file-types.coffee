CustomFileTypesView = require './custom-file-types-view'
{CompositeDisposable} = require 'atom'

module.exports = CustomFileTypes =
  customFileTypesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @customFileTypesView = new CustomFileTypesView(state.customFileTypesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @customFileTypesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'custom-file-types:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @customFileTypesView.destroy()

  serialize: ->
    customFileTypesViewState: @customFileTypesView.serialize()

  toggle: ->
    console.log 'CustomFileTypes was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
