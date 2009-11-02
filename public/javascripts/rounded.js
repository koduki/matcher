addEvent(window, 'load', initCorners);
function initCorners() {

  var settings = {
    tl: { radius: 20 },
    tr: { radius: 20 },
    bl: { radius: 20 },
    br: { radius: 20 },
    antiAlias: true
  };

  curvyCorners(settings, "#myBox");
}