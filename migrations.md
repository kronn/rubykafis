---
title: Rails DB-Migrations - Best Practices
theme: theme/puzzle.css
revealOptions:
    transition: 'fade'
---

# Ruby Kafi Juni 2021

<!-- .slide: class="master01" -->

----

# Rails Kafi Juni 2021

<!-- .slide: class="master01" -->

----

# Rails Migrations
## &nbsp;

<img src="rails.png" alt="The Rails Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Rails Migrations
## was kann schon schief gehen?

<img src="rails.png" alt="The Rails Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Überblick

<ol>
<li class="fragment">DB-Migrations
<li class="fragment">Ruby? Rails? SQL?
<li class="fragment">Datenänderungen
<li class="fragment">Umkehrbarkeit
<li class="fragment">Fazit
</ol>

<!-- .slide: class="master01" -->

----

# Annahmen

<ul>
<li class="fragment">ActiveRecord
<li class="fragment">PostgreSQL
</ul>

<!-- .slide: class="master01" -->

---

# ActiveRecord Migrations

<!-- .slide: class="master02 intro" -->

----

# Überblick

```ruby
class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
```

<!-- .slide: class="master02" -->

----

# Anlegen

```shell
bin/rails generate migration create_products \
          name:string \
          description:text
```

<!-- .slide: class="master02" -->

----

# Ausführen

```shell
bin/rails db:migrate
```

<!-- .slide: class="master02" -->

----

# Status ansehen

```shell
bin/rails db:migrate:status
```

<!-- .slide: class="master02" -->

----

# Tricks

```shell
bin/rails generate migrate add_columns_to_table \
          name:string
```

```shell
bin/rails generate migrate remove_columns_from_table \
          name:string
```

<!-- .slide: class="master02" -->

---

# DSL
## Klar, aber welche?

<!-- .slide: class="master03 intro" -->

----

# ActiveRecord

<ul>
<li class="fragment">create_table
<li class="fragment">add_column
<li class="fragment">add_index
<li class="fragment">change_column_default
<li class="fragment">remove_column
<li class="fragment">...
</ul>

Note: Wie in den Tutorials, der Doku und den BestPractices beschrieben.

<!-- .slide: class="master03" -->

----

# Applikationscode

<ul>
<li class="fragment">UserPerson.backfill_data!
<li class="fragment">ProductArticle.where(cond).destroy_all
<li class="fragment">OldProduct.create(titel: 'blørbaël')
<li class="fragment">UserPerson.create_initial_data!
</ul>

## (besser nicht)

Note: `backfill_data` kann und wird sich ändern. `destroy_all` ruft callbacks auf. OldProduct existiert vllt nicht mehr

<!-- .slide: class="master03" -->

----

# Ruby

<ul>
<li class="fragment">[ ].each {}
<li class="fragment">Pathname.new(fn).read.lines { }
<li class="fragment">def
</ul>

Note: Loops sind okay, Importe besser via SeedFu, Methoden sind wieder okay

<!-- .slide: class="master03" -->

----

# SQL

<ul>
<li class="fragment">execute "DROP TABLE students"
<li class="fragment">execute "CREATE INDEX CONCURRENTLY idx_name ON people(name)"
<li class="fragment">execute "ALTER TABLE people ADD CONSTRAINT..."
</ul>

Note: execute ist hilfreich, aber aus großer Macht erwächst große Verantwortung

<!-- .slide: class="master03" -->

----

# SQL

```ruby
say_with_time 'Adding constraint' do
  execute "ALTER TABLE people ADD CONSTRAINT..."
end
```

## weil logs gelesen werden

Note: say_with_time macht den output verständlich

<!-- .slide: class="master03" -->

----

# Gems

```ruby
say_with_time('creating translation table for events') do
  Event.create_translation_table!(
    {
      name: :string,
      description: :text,
    },
    { migrate_data: true, remove_source_columns: true }
  )
end
```

Note: die migration und die app läuft nur noch mit globalize

<!-- .slide: class="master03" -->

---

# Datenmigrationen

<!-- .slide: class="master02 intro" -->

----

# SQL

```ruby
say_with_time 'Adding new settings' do
  settings.each do |name, value|
    execute "INSERT INTO settings (name, value) VALUES (#{name}, #{value})"
  end
end
```
<ul>
</ul>

<!-- .slide: class="master02" -->

----

# ActiveRecord

```ruby
say_with_time('Migrating old things to new things') do
  OldThing.find_each do |old|
    NewThing.create(name: old.name)
  end
end
```

Note: nur Methoden in ActiveRecord::Base verwenden

<!-- .slide: class="master02" -->

----

# SeedFu

```ruby
UserPerson.seed(new_data)

PersonUser.seed_once(:email, new_data)
```

Note: eher ein eigener rake-task, weil es nur in bestimmten Systemen passiert oder ohnehin mit rake db:seed gemacht wird.

<!-- .slide: class="master02" -->

---

# up, down und redo
## Richtungen einer Migration

<!-- .slide: class="master03 intro" -->

----

# Bis zur Unendlichkeit...

```shell
bin/rails db:migrate
```

```ruby
class CreateProducts < ActiveRecord::Migration[6.0]
  def change
  end
end
```

<!-- .slide: class="master03" -->

----

# rake db:migrate:...

<ul>
<li class="fragment">up VERSION=20210202153103
<li class="fragment">down VERSION=20210202153103
<li class="fragment"><b>redo</b>
<li class="fragment"><b>status</b>
<li class="fragment">reset
</ul>

<!-- .slide: class="master03" -->

----

# rake ~db:migrate:~...

- db:migrate
- db:rollback
- <b>db:migate:redo</b>
- <b>db:migrate:status</b>
- db:reset

<!-- .slide: class="master03" -->

----

# Getrennte Wege

```ruby
class CreateProducts < ActiveRecord::Migration[6.0]
  def up
    create_table :products { ... }
    fill_with_data # not shown
    create_index
  end

  def down
    drop_table :products
  end
end
```

Note: wenn eine Richtung deutlich anders als die andere ist

<!-- .slide: class="master03" -->

----

# Einbahnstrassen

```ruby
class DropChinaVases < ActiveRecord::Migration[6.0]
  def up
    drop_table :china_vases
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
```

Note: Passiert selten, aber öfter, als man denkt

<!-- .slide: class="master03" -->

----

# Gemeinsam einsam

```ruby
class ChangeColumnLimitsOnHelpTexts < ActiveRecord::Migration[6.0]
  def change
    reversible do |dirs|
      dirs.up do # reduce size so the index can handle utf-8
        change_column :help_texts, :controller, :string, limit: 100
      end
      dirs.down do # revert back to defaults
        change_column :help_texts, :controller, :string
      end
    end
  end
end
```

<!-- .slide: class="master03" -->

---

# Also...

<!-- .slide: class="master04 intro" -->

----

# Strukturmigrationen

<ul>
<li class="fragment">nur die Migrations-DSL nutzen
<li class="fragment">ggf. Hilfsmethoden aus gems
<li class="fragment">notfalls execute
<li class="fragment">mit say_with_time
</ul>

<!-- .slide: class="master04" -->

----

# Datenmigrationen

<ul>
<li class="fragment">keinen Model-Code verwenden
<li class="fragment">nur Methoden aus AR::Base
<li class="fragment">direkt SQL mit execute
<li class="fragment">mit say_with_time
</ul>

<!-- .slide: class="master04" -->

----

# Umkehrbarkeit

<ul>
<li class="fragment">reversible { |dirs| dirs.up {}; dirs.down {} }
<li class="fragment">up und down statt change
<li class="fragment">ActiveRecord::IrreversibleMigration
<li class="fragment">rake db:migrate:redo für manuelle Tests
</ul>

<!-- .slide: class="master04" -->

----

# Verschiedenes

<ul>
<li class="fragment">schema.rb / structure.sql hat nur Struktur
<li class="fragment">Initialdaten mit seeds laden
<li class="fragment">Migration-Klasse immer mit Verb beginnen
<li class="fragment">Migrationen mindestens manuell testen
<li class="fragment">migration.verbose = false in Specs
</ul>

Note: Klassenprefixes: Add, Create, Remove, Change, Migrate...

<!-- .slide: class="master04" -->

----

# Schichten

<ul>
<li class="fragment">Die App braucht die DB
<li class="fragment">Die DB braucht die App nicht
<li class="fragment">Rails hilft bei Migrationen
<li class="fragment">Applikationslogik hilft nicht
<li class="fragment">Respektiert diese Grenze
</ul>

<!-- .slide: class="master04" -->

---

# Merci viumau

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Link

* https://guides.rubyonrails.org/active_record_migrations.html

<!-- .slide: class="master01" -->
