###
  Shortcuts for Framer 1.0
  http://github.com/facebook/shortcuts-for-framer

  Copyright (c) 2014, Facebook, Inc.
  All rights reserved.

  Readme:
  https://github.com/facebook/shortcuts-for-framer

  License:
  https://github.com/facebook/shortcuts-for-framer/blob/master/LICENSE.md
###

# CONFIGURATION

Framer.Shortcuts = {}

###
  Shorthand for applying a function to every layer in the document.
  Example:
  ```Framer.Shortcuts.everyLayer(function(layer) {
    layer.visible = false;
  });```
###

Framer.Shortcuts.everyLayer = (fn) ->
  for layerName of window.Layers
    _layer = window.Layers[layerName]
    fn _layer

### SHORTHAND FOR ACCESSING LAYERS

  Convert each layer coming from the exporter into a Javascript object for shorthand access.

  This has to be called manually in Framer3 after you've ran the importer.

  myLayers = Framer.Importer.load("...")
  Framer.Shortcuts.initialize(myLayers)

  If you have a layer in your PSD/Sketch called "NewsFeed", this will create a global Javascript variable called "NewsFeed" that you can manipulate with Framer.

  Example:
  `NewsFeed.visible = false;`

  Notes:
  Javascript has some names reserved for internal function that you can't override (for ex. )
###

Framer.Shortcuts.initialize = (layers) ->
  if layers?
    window.Layers = layers

    Framer.Shortcuts.everyLayer (layer) ->
      sanitizedLayerName = layer.name.replace(/[-+!?:*\[\]\(\)\/]/g, '').trim().replace(/\s/g, '_')
      window[sanitizedLayerName] = layer
      Framer.Shortcuts.saveOriginalFrame layer

### ORIGINAL FRAME

  Stores the initial location and size of a layer in the "originalFrame" attribute, so you can revert to it later on.

  Example:
  The x coordinate of MyLayer is initially 400 (from the PSD)

  ```MyLayer.x = 200; // now we set it to 200.
  MyLayer.x = MyLayer.originalFrame.x // now we set it back to its original value, 400.```
###

Framer.Shortcuts.saveOriginalFrame = (layer) ->
  layer.originalFrame = layer.frame


