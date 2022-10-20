/* Main.c generated by valac 0.48.25, the Vala compiler
 * generated from Main.vala, do not modify */

#include <gtk/gtk.h>
#include <glib-object.h>
#include <granite.h>
#include <glib.h>

#define VS_CODE_LAYOUTS_TYPE_MAIN (vs_code_layouts_main_get_type ())
#define VS_CODE_LAYOUTS_MAIN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMain))
#define VS_CODE_LAYOUTS_MAIN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMainClass))
#define VS_CODE_LAYOUTS_IS_MAIN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), VS_CODE_LAYOUTS_TYPE_MAIN))
#define VS_CODE_LAYOUTS_IS_MAIN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), VS_CODE_LAYOUTS_TYPE_MAIN))
#define VS_CODE_LAYOUTS_MAIN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMainClass))

typedef struct _VSCodeLayoutsMain VSCodeLayoutsMain;
typedef struct _VSCodeLayoutsMainClass VSCodeLayoutsMainClass;
typedef struct _VSCodeLayoutsMainPrivate VSCodeLayoutsMainPrivate;

#define VS_CODE_LAYOUTS_TYPE_WELCOME (vs_code_layouts_welcome_get_type ())
#define VS_CODE_LAYOUTS_WELCOME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), VS_CODE_LAYOUTS_TYPE_WELCOME, VSCodeLayoutsWelcome))
#define VS_CODE_LAYOUTS_WELCOME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), VS_CODE_LAYOUTS_TYPE_WELCOME, VSCodeLayoutsWelcomeClass))
#define VS_CODE_LAYOUTS_IS_WELCOME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), VS_CODE_LAYOUTS_TYPE_WELCOME))
#define VS_CODE_LAYOUTS_IS_WELCOME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), VS_CODE_LAYOUTS_TYPE_WELCOME))
#define VS_CODE_LAYOUTS_WELCOME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), VS_CODE_LAYOUTS_TYPE_WELCOME, VSCodeLayoutsWelcomeClass))

typedef struct _VSCodeLayoutsWelcome VSCodeLayoutsWelcome;
typedef struct _VSCodeLayoutsWelcomeClass VSCodeLayoutsWelcomeClass;

#define VS_CODE_TYPE_WINDOW (vs_code_window_get_type ())
#define VS_CODE_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), VS_CODE_TYPE_WINDOW, VSCodeWindow))
#define VS_CODE_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), VS_CODE_TYPE_WINDOW, VSCodeWindowClass))
#define VS_CODE_IS_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), VS_CODE_TYPE_WINDOW))
#define VS_CODE_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), VS_CODE_TYPE_WINDOW))
#define VS_CODE_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), VS_CODE_TYPE_WINDOW, VSCodeWindowClass))

typedef struct _VSCodeWindow VSCodeWindow;
typedef struct _VSCodeWindowClass VSCodeWindowClass;
enum  {
	VS_CODE_LAYOUTS_MAIN_0_PROPERTY,
	VS_CODE_LAYOUTS_MAIN_WINDOW_PROPERTY,
	VS_CODE_LAYOUTS_MAIN_NUM_PROPERTIES
};
static GParamSpec* vs_code_layouts_main_properties[VS_CODE_LAYOUTS_MAIN_NUM_PROPERTIES];
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _VSCodeLayoutsMain {
	GtkPaned parent_instance;
	VSCodeLayoutsMainPrivate * priv;
	VSCodeLayoutsWelcome* welcome;
	GtkStack* sidebar_stack;
	GtkStack* main_stack;
};

struct _VSCodeLayoutsMainClass {
	GtkPanedClass parent_class;
};

struct _VSCodeLayoutsMainPrivate {
	VSCodeWindow* _window;
};

static gint VSCodeLayoutsMain_private_offset;
static gpointer vs_code_layouts_main_parent_class = NULL;

GType vs_code_layouts_main_get_type (void) G_GNUC_CONST;
G_DEFINE_AUTOPTR_CLEANUP_FUNC (VSCodeLayoutsMain, g_object_unref)
GType vs_code_layouts_welcome_get_type (void) G_GNUC_CONST;
G_DEFINE_AUTOPTR_CLEANUP_FUNC (VSCodeLayoutsWelcome, g_object_unref)
GType vs_code_window_get_type (void) G_GNUC_CONST;
G_DEFINE_AUTOPTR_CLEANUP_FUNC (VSCodeWindow, g_object_unref)
VSCodeLayoutsMain* vs_code_layouts_main_new (VSCodeWindow* main_window);
VSCodeLayoutsMain* vs_code_layouts_main_construct (GType object_type,
                                                   VSCodeWindow* main_window);
void vs_code_layouts_main_build_sidebar (VSCodeLayoutsMain* self);
void vs_code_layouts_main_build_main (VSCodeLayoutsMain* self);
VSCodeWindow* vs_code_layouts_main_get_window (VSCodeLayoutsMain* self);
static void vs_code_layouts_main_set_window (VSCodeLayoutsMain* self,
                                      VSCodeWindow* value);
static GObject * vs_code_layouts_main_constructor (GType type,
                                            guint n_construct_properties,
                                            GObjectConstructParam * construct_properties);
VSCodeLayoutsWelcome* vs_code_layouts_welcome_new (VSCodeWindow* main_window);
VSCodeLayoutsWelcome* vs_code_layouts_welcome_construct (GType object_type,
                                                         VSCodeWindow* main_window);
static void vs_code_layouts_main_finalize (GObject * obj);
static GType vs_code_layouts_main_get_type_once (void);
static void _vala_vs_code_layouts_main_get_property (GObject * object,
                                              guint property_id,
                                              GValue * value,
                                              GParamSpec * pspec);
static void _vala_vs_code_layouts_main_set_property (GObject * object,
                                              guint property_id,
                                              const GValue * value,
                                              GParamSpec * pspec);

static inline gpointer
vs_code_layouts_main_get_instance_private (VSCodeLayoutsMain* self)
{
	return G_STRUCT_MEMBER_P (self, VSCodeLayoutsMain_private_offset);
}

VSCodeLayoutsMain*
vs_code_layouts_main_construct (GType object_type,
                                VSCodeWindow* main_window)
{
	VSCodeLayoutsMain * self = NULL;
#line 13 "../src/Layouts/Main.vala"
	g_return_val_if_fail (main_window != NULL, NULL);
#line 14 "../src/Layouts/Main.vala"
	self = (VSCodeLayoutsMain*) g_object_new (object_type, "orientation", GTK_ORIENTATION_HORIZONTAL, "window", main_window, NULL);
#line 13 "../src/Layouts/Main.vala"
	return self;
#line 115 "Main.c"
}

VSCodeLayoutsMain*
vs_code_layouts_main_new (VSCodeWindow* main_window)
{
#line 13 "../src/Layouts/Main.vala"
	return vs_code_layouts_main_construct (VS_CODE_LAYOUTS_TYPE_MAIN, main_window);
#line 123 "Main.c"
}

void
vs_code_layouts_main_build_sidebar (VSCodeLayoutsMain* self)
{
	GtkStack* _tmp0_;
#line 31 "../src/Layouts/Main.vala"
	g_return_if_fail (self != NULL);
#line 32 "../src/Layouts/Main.vala"
	_tmp0_ = self->sidebar_stack;
#line 32 "../src/Layouts/Main.vala"
	gtk_paned_pack1 ((GtkPaned*) self, (GtkWidget*) _tmp0_, FALSE, FALSE);
#line 136 "Main.c"
}

void
vs_code_layouts_main_build_main (VSCodeLayoutsMain* self)
{
	GtkStack* _tmp0_;
#line 35 "../src/Layouts/Main.vala"
	g_return_if_fail (self != NULL);
#line 36 "../src/Layouts/Main.vala"
	_tmp0_ = self->main_stack;
#line 36 "../src/Layouts/Main.vala"
	gtk_paned_pack2 ((GtkPaned*) self, (GtkWidget*) _tmp0_, TRUE, FALSE);
#line 149 "Main.c"
}

VSCodeWindow*
vs_code_layouts_main_get_window (VSCodeLayoutsMain* self)
{
	VSCodeWindow* result;
	VSCodeWindow* _tmp0_;
#line 3 "../src/Layouts/Main.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 3 "../src/Layouts/Main.vala"
	_tmp0_ = self->priv->_window;
#line 3 "../src/Layouts/Main.vala"
	result = _tmp0_;
#line 3 "../src/Layouts/Main.vala"
	return result;
#line 165 "Main.c"
}

static void
vs_code_layouts_main_set_window (VSCodeLayoutsMain* self,
                                 VSCodeWindow* value)
{
	VSCodeWindow* old_value;
#line 3 "../src/Layouts/Main.vala"
	g_return_if_fail (self != NULL);
#line 3 "../src/Layouts/Main.vala"
	old_value = vs_code_layouts_main_get_window (self);
#line 3 "../src/Layouts/Main.vala"
	if (old_value != value) {
#line 3 "../src/Layouts/Main.vala"
		self->priv->_window = value;
#line 3 "../src/Layouts/Main.vala"
		g_object_notify_by_pspec ((GObject *) self, vs_code_layouts_main_properties[VS_CODE_LAYOUTS_MAIN_WINDOW_PROPERTY]);
#line 183 "Main.c"
	}
}

static GObject *
vs_code_layouts_main_constructor (GType type,
                                  guint n_construct_properties,
                                  GObjectConstructParam * construct_properties)
{
	GObject * obj;
	GObjectClass * parent_class;
	VSCodeLayoutsMain * self;
	GtkStack* _tmp0_;
	VSCodeWindow* _tmp1_;
	VSCodeLayoutsWelcome* _tmp2_;
	GtkStack* _tmp3_;
	VSCodeLayoutsWelcome* _tmp4_;
#line 20 "../src/Layouts/Main.vala"
	parent_class = G_OBJECT_CLASS (vs_code_layouts_main_parent_class);
#line 20 "../src/Layouts/Main.vala"
	obj = parent_class->constructor (type, n_construct_properties, construct_properties);
#line 20 "../src/Layouts/Main.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMain);
#line 23 "../src/Layouts/Main.vala"
	_tmp0_ = (GtkStack*) gtk_stack_new ();
#line 23 "../src/Layouts/Main.vala"
	g_object_ref_sink (_tmp0_);
#line 23 "../src/Layouts/Main.vala"
	_g_object_unref0 (self->main_stack);
#line 23 "../src/Layouts/Main.vala"
	self->main_stack = _tmp0_;
#line 24 "../src/Layouts/Main.vala"
	_tmp1_ = self->priv->_window;
#line 24 "../src/Layouts/Main.vala"
	_tmp2_ = vs_code_layouts_welcome_new (_tmp1_);
#line 24 "../src/Layouts/Main.vala"
	g_object_ref_sink (_tmp2_);
#line 24 "../src/Layouts/Main.vala"
	_g_object_unref0 (self->welcome);
#line 24 "../src/Layouts/Main.vala"
	self->welcome = _tmp2_;
#line 25 "../src/Layouts/Main.vala"
	_tmp3_ = self->main_stack;
#line 25 "../src/Layouts/Main.vala"
	_tmp4_ = self->welcome;
#line 25 "../src/Layouts/Main.vala"
	gtk_stack_add_named (_tmp3_, (GtkWidget*) _tmp4_, "welcome");
#line 27 "../src/Layouts/Main.vala"
	vs_code_layouts_main_build_sidebar (self);
#line 28 "../src/Layouts/Main.vala"
	vs_code_layouts_main_build_main (self);
#line 20 "../src/Layouts/Main.vala"
	return obj;
#line 236 "Main.c"
}

static void
vs_code_layouts_main_class_init (VSCodeLayoutsMainClass * klass,
                                 gpointer klass_data)
{
#line 2 "../src/Layouts/Main.vala"
	vs_code_layouts_main_parent_class = g_type_class_peek_parent (klass);
#line 2 "../src/Layouts/Main.vala"
	g_type_class_adjust_private_offset (klass, &VSCodeLayoutsMain_private_offset);
#line 2 "../src/Layouts/Main.vala"
	G_OBJECT_CLASS (klass)->get_property = _vala_vs_code_layouts_main_get_property;
#line 2 "../src/Layouts/Main.vala"
	G_OBJECT_CLASS (klass)->set_property = _vala_vs_code_layouts_main_set_property;
#line 2 "../src/Layouts/Main.vala"
	G_OBJECT_CLASS (klass)->constructor = vs_code_layouts_main_constructor;
#line 2 "../src/Layouts/Main.vala"
	G_OBJECT_CLASS (klass)->finalize = vs_code_layouts_main_finalize;
#line 2 "../src/Layouts/Main.vala"
	g_object_class_install_property (G_OBJECT_CLASS (klass), VS_CODE_LAYOUTS_MAIN_WINDOW_PROPERTY, vs_code_layouts_main_properties[VS_CODE_LAYOUTS_MAIN_WINDOW_PROPERTY] = g_param_spec_object ("window", "window", "window", VS_CODE_TYPE_WINDOW, G_PARAM_STATIC_STRINGS | G_PARAM_READABLE | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY));
#line 257 "Main.c"
}

static void
vs_code_layouts_main_instance_init (VSCodeLayoutsMain * self,
                                    gpointer klass)
{
#line 2 "../src/Layouts/Main.vala"
	self->priv = vs_code_layouts_main_get_instance_private (self);
#line 266 "Main.c"
}

static void
vs_code_layouts_main_finalize (GObject * obj)
{
	VSCodeLayoutsMain * self;
#line 2 "../src/Layouts/Main.vala"
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMain);
#line 7 "../src/Layouts/Main.vala"
	_g_object_unref0 (self->welcome);
#line 10 "../src/Layouts/Main.vala"
	_g_object_unref0 (self->sidebar_stack);
#line 11 "../src/Layouts/Main.vala"
	_g_object_unref0 (self->main_stack);
#line 2 "../src/Layouts/Main.vala"
	G_OBJECT_CLASS (vs_code_layouts_main_parent_class)->finalize (obj);
#line 283 "Main.c"
}

static GType
vs_code_layouts_main_get_type_once (void)
{
	static const GTypeInfo g_define_type_info = { sizeof (VSCodeLayoutsMainClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) vs_code_layouts_main_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (VSCodeLayoutsMain), 0, (GInstanceInitFunc) vs_code_layouts_main_instance_init, NULL };
	GType vs_code_layouts_main_type_id;
	vs_code_layouts_main_type_id = g_type_register_static (gtk_paned_get_type (), "VSCodeLayoutsMain", &g_define_type_info, 0);
	VSCodeLayoutsMain_private_offset = g_type_add_instance_private (vs_code_layouts_main_type_id, sizeof (VSCodeLayoutsMainPrivate));
	return vs_code_layouts_main_type_id;
}

GType
vs_code_layouts_main_get_type (void)
{
	static volatile gsize vs_code_layouts_main_type_id__volatile = 0;
	if (g_once_init_enter (&vs_code_layouts_main_type_id__volatile)) {
		GType vs_code_layouts_main_type_id;
		vs_code_layouts_main_type_id = vs_code_layouts_main_get_type_once ();
		g_once_init_leave (&vs_code_layouts_main_type_id__volatile, vs_code_layouts_main_type_id);
	}
	return vs_code_layouts_main_type_id__volatile;
}

static void
_vala_vs_code_layouts_main_get_property (GObject * object,
                                         guint property_id,
                                         GValue * value,
                                         GParamSpec * pspec)
{
	VSCodeLayoutsMain * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (object, VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMain);
#line 2 "../src/Layouts/Main.vala"
	switch (property_id) {
#line 2 "../src/Layouts/Main.vala"
		case VS_CODE_LAYOUTS_MAIN_WINDOW_PROPERTY:
#line 2 "../src/Layouts/Main.vala"
		g_value_set_object (value, vs_code_layouts_main_get_window (self));
#line 2 "../src/Layouts/Main.vala"
		break;
#line 324 "Main.c"
		default:
#line 2 "../src/Layouts/Main.vala"
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
#line 2 "../src/Layouts/Main.vala"
		break;
#line 330 "Main.c"
	}
}

static void
_vala_vs_code_layouts_main_set_property (GObject * object,
                                         guint property_id,
                                         const GValue * value,
                                         GParamSpec * pspec)
{
	VSCodeLayoutsMain * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (object, VS_CODE_LAYOUTS_TYPE_MAIN, VSCodeLayoutsMain);
#line 2 "../src/Layouts/Main.vala"
	switch (property_id) {
#line 2 "../src/Layouts/Main.vala"
		case VS_CODE_LAYOUTS_MAIN_WINDOW_PROPERTY:
#line 2 "../src/Layouts/Main.vala"
		vs_code_layouts_main_set_window (self, g_value_get_object (value));
#line 2 "../src/Layouts/Main.vala"
		break;
#line 350 "Main.c"
		default:
#line 2 "../src/Layouts/Main.vala"
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
#line 2 "../src/Layouts/Main.vala"
		break;
#line 356 "Main.c"
	}
}
