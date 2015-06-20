About = require '../lib/about'

describe "About", ->
  workspaceElement = null

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)

    waitsForPromise ->
      atom.packages.activatePackage('about')

  describe "when the about:about-atom command is triggered", ->
    it "shows the About Atom view", ->
      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.about-atom')).not.toExist()
      atom.commands.dispatch workspaceElement, 'about:about-atom'

      waitsFor ->
        atom.workspace.getActivePaneItem()

      runs ->
        aboutElement = workspaceElement.querySelector('.about-atom')
        expect(aboutElement).toBeVisible()