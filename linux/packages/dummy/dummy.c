#include <gtk/gtk.h>

static void activate (GtkApplication* app, gpointer user_data) {
  GtkWidget *window;
  GtkWidget *label;

  window = gtk_application_window_new(app);
  gtk_window_set_default_size(GTK_WINDOW (window), 0, 0);
  gtk_window_set_modal(GTK_WINDOW (window), TRUE);
  gtk_window_set_decorated(GTK_WINDOW(window), FALSE);
  gtk_widget_show_all(window);
}

int main (int argc, char **argv) {
  GtkApplication *app;
  int status;

  app = gtk_application_new ("org.gtk_example", G_APPLICATION_FLAGS_NONE);
  g_signal_connect (app, "activate", G_CALLBACK (activate), NULL);
  status = g_application_run (G_APPLICATION (app), argc, argv);
  g_object_unref (app);

  return status;
}
