#macro CB_RENDER_VERSION  "3.0.0"
#macro CB_RENDER_DATE     "2024-06-16"

#macro CB_RENDER_NORMATIVE  ((os_type == os_xboxone) || (os_type == os_xboxseriesxs) || (os_type == os_ps5) || (os_type == os_windows))

#macro CB_LIGHTING_DISABLED            0
#macro CB_LIGHTING_NO_SHADOWED_LIGHTS  1
#macro CB_LIGHTING_ONE_SHADOWED_LIGHT  2
#macro CB_LIGHTING_DEFERRED            3