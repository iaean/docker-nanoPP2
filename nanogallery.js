function initNanogallery2 (i, t, a, u) {
    // Grid and justified layout depending on the resolution:
    // thumbnailWidth:     'auto XS80 SM100 ME150 LA230 XL440',
    // thumbnailHeight:    '150 XS80 SM120 ME150 LA230 XL440'
    // Justified and cascading layout depending on the resolution:
    // thumbnailWidth":   'auto XS80 SM120 ME150 LA230 XL440',
    // thumbnailHeight":  '150 XSauto SMauto MEauto LAauto XLauto'
    // allowedSizeValues = "80|100|150|230|440|auto"

    var providerUrlPrefix = u ? u : "/nanoPP2/galleries/";
    $(i).nanogallery2({
      thumbnailL1Height:       "auto",
      thumbnailL1Width:        "50 XS80 SM100 ME150 LA230 XL440",
      thumbnailL1HoverEffect2: "imageGrayOn|scale120|borderLighter",
      thumbnailL1Label: {
        position:           "onBottom",
        hideIcons:          false,
        display:            true,
        displayDescription: false,
        titleFontSize:      "0.75em"
      },
      thumbnailHeight:       "50 XS80 SM100 ME150 LA230 XL440",
      thumbnailWidth:        "auto",
      thumbnailHoverEffect2: "imageGrayOn|scale120|borderLighter",
      thumbnailLabel: {
        position:           "onBottom",
        hideIcons:          false,
        display:            false,
        displayDescription: false,
        titleFontSize:      "0.75em"
      },
      thumbnailAlignment:            "center",
      thumbnailDisplayOutsideScreen: false,
      thumbnailWaitImageLoaded:      false,
      viewerToolbar: {
        standard: "minimizeButton, label, fullscreenButton",
        minimized: "minimizeButton, label, shareButton, downloadButton, linkOriginalButton, fullscreenButton" },
      galleryL1DisplayMode:  "pagination",
      galleryL1MaxRows:      5,
      galleryL1FilterTags:   false,
      galleryL1LastRowFull:  false,
      galleryL1Sorting:      "random",
      // galleryDisplayMode:    "pagination",
      // galleryMaxRows:        4,
      galleryDisplayMode:    "rows",
      galleryMaxRows:        3,
      galleryFilterTags:     true,
      galleryLastRowFull:    true,
      gallerySorting:        "random",
      galleryPaginationMode: "rectangles",
      galleryTheme:          "light",

      openOnStart:           a ? encodeURI(a) : undefined,
      displayBreadcrumb:     a ? false : true,

      navigationFontSize:    "1.0em",
      viewerTheme:           "dark",
      slideshowAutoStart:    true,
      imageTransition:       "slideAppear",
      kind:                  "nano_photos_provider2",
      dataProvider:          providerUrlPrefix + "nano_photos_provider2.php",
      locationHash:          false
    });

    /* refreshing none root album views... */
    var ngy2data = $(i).nanogallery2("data");
    if (t) {
      var timer = setInterval(function() {
        if (ngy2data.items[ngy2data.gallery.albumIdx].GetID() != "0") {
          $(i).nanogallery2("reload"); }
        else { } }, t * 1000); }
}