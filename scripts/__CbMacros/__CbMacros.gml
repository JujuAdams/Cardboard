#macro __CB_ON_DIRECTX  ((os_type == os_windows) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs) || (os_type == os_uwp) || (os_type == os_win8native) || (os_type == os_winphone))
#macro __CB_ON_MOBILE   ((os_type == os_ios) || (os_type == os_android) || (os_type == os_tvos))
#macro __CB_ON_WEB      (os_browser != browser_not_a_browser)
#macro __CB_ON_OPENGL   (!__CB_ON_DIRECTX || __CB_ON_WEB)