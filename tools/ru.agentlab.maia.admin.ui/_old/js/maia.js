var maia = maia || {};
dispatch = d3.dispatch(
	"context_load",
	"context_focus",
	"context_hover_start",
	"context_hover_inprogress",
	"context_hover_end",
	"context_refresh",
	"context_open",
	"context_close",
	"context_add",
	"context_remove",
	"services_load_end",
	"service_hover_start",
	"service_hover_inprogress",
	"service_hover_end",
	"bundle_update",
	"filter_change");

maia.root = {};