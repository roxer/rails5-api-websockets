CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "api_v1_canvases" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "api_v1_diagram_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_api_v1_canvases_on_api_v1_diagram_id" ON "api_v1_canvases" ("api_v1_diagram_id");
CREATE TABLE "api_v1_diagrams" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "api_v1_shapes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "label" varchar NOT NULL, "shape_type" varchar NOT NULL, "descriptors" text NOT NULL, "pos_x" integer NOT NULL, "pos_y" integer NOT NULL, "canvas_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_api_v1_shapes_on_canvas_id" ON "api_v1_shapes" ("canvas_id");
INSERT INTO schema_migrations (version) VALUES ('20151216063948');

INSERT INTO schema_migrations (version) VALUES ('20151216065921');

INSERT INTO schema_migrations (version) VALUES ('20151218210922');

