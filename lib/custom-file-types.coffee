CustomFileTypesView = require './custom-file-types-view'
{CompositeDisposable} = require 'atom'

module.exports = CustomFileTypes =
  customFileTypesView: null
  paneItem: null
  subscriptions: null

  activate: (state) ->
    @customFileTypesView = new CustomFileTypesView(state.customFileTypesViewState)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'custom-file-types:toggle': => @toggle()

  deactivate: ->
    @paneItem.destroy()
    @subscriptions.dispose()
    @customFileTypesView.destroy()

  serialize: ->
    customFileTypesViewState: @customFileTypesView.serialize()

  toggle: ->
    @paneItem = atom.workspace.getActivePane().activateItem(@customFileTypesView)
