---
title: hitobito - a tech-dive
theme: theme/puzzle.css
revealOptions:
    transition: 'fade'
---

# RailsHöck 2022

<!-- .slide: class="master01" -->

----

# Tech Dive Into 人人
### &nbsp;

<img src="hitobito.png" alt="The Hitobito Logo">

<!-- .slide: class="master01" -->

----

# `whoami`

<ul>
<li class="fragment">Matthias Viehweger
<li class="fragment">Ruby since 1.8.7
<li class="fragment">Rails since 2.3
<li class="fragment">Puzzle ITC since 2016
<li class="fragment">github.com/kronn
</ul>

<!-- .slide: class="master01" -->

----

# Agenda

<ol>
<li class="fragment">Overview of hitobito
<li class="fragment">Technicalities
<li class="fragment">Questions
</ol>

<!-- .slide: class="master01" -->

Note:
I want to
- give an overview of hitobito,
- go into some technical aspects,
- hopefully have some time for Q&A

----

# Non-Topics

<ol>
<li class="fragment">Code-Style
<li class="fragment">Operations
<li class="fragment">Banking
</ol>

Note:
- Code-Style -> RuboCop
- Operations -> 108 Minute Podcast
- Banking -> present, but more than we have time

<!-- .slide: class="master01" -->

---

# 人人 hitobito

<!-- .slide: class="master02 intro" -->

----

# What is it?

> Hitobito ist die webbasierte Open Source Lösung zur modernen und effizienten Verwaltung von Verbänden, Vereinen und Organisationen mit einfachen bis komplexen Strukturen.

Note: Hitobito is the web-based Open Source-Solution for modern and efficient administration of assocications, clubs and organizations with both simple and complex structures.

<!-- .slide: class="master02" -->

----

# What, really?

<ul>
<li class="fragment">better than Calc/Excel/Numbers
<li class="fragment">people -[roles]-> groups
<li class="fragment">custom group-structures
<li class="fragment">connection-hub
</ul>

Note: members and groups at the center

<!-- .slide: class="master02" -->

----

# Tech-Stack

- Rails 6.1
- Ruby 2.7
- MySQL 5.7 or 8
- Sphinx 2.2
- delayed job
- memcached
- wagons

Note:
Mysql 5.7 in production
Dated stack?
10 Years and 1 month old today

<!-- .slide: class="master02" -->

----

# Wagons

<ul>
<li class="fragment">are engines
<li class="fragment">but somewhat inverted
<li class="fragment">core as app + wagons in vendor/
<li class="fragment">Group-Structures live here
<li class="fragment">custom features as well
</ul>

Note:
At least one wagon for the organization, but can be more:
hitobito-youth for Youth-organizations.

<!-- .slide: class="master02" -->

----

# 人人 HITOBITO

- better than Calc/Excel/Numbers
- people -[roles]-> groups
- custom group-structures
- connection-hub <span class="fragment">with technicalities</span>

<!-- .slide: class="master02" -->

---

# The Technicalities

- Detailed Abilities
- MailingLists
- OAuth-Provider
- API

Note:
or: why is it a connection hub?

<!-- .slide: class="master03 intro" -->

----

# Abilities

<ul>
<li class="fragment">based on CanCanCan
<li class="fragment">some helper-methods
</ul>

<!-- .slide: class="master02" -->

----

# Abilities

```ruby
class MailingListAbility < AbilityDsl::Base
  include AbilityDsl::Constraints::Group

  on(::MailingList) do
    permission(:any).may(:show).subscribable
    permission(:group_full)
      .may(:show, :index_subscriptions).in_same_group
  end

  on(Imap::Mail) do
    permission(:admin).may(:manage)
      .if_mail_config_present
  end
```

<!-- .slide: class="master02" -->

----

# Abilities

```ruby
class Group::Bund < Group
  class ItSupport < ::Role
    self.permissions = [
      :group_full, :contact_data, :admin,
      :impersonation
    ]
  end

  class Mitglied < ::Role
    self.permissions = [
      :group_read
    ]
  end
```

<!-- .slide: class="master02" -->

----

# MailingLists

<ul>
<li class="fragment">read from a catch-all inbox
<li class="fragment">multiplexes mail
<li class="fragment">to a group
<li class="fragment">to members
<li class="fragment">with exclusions
</ul>

Note:
All Application evolve until they envelop mail-capabilities.

<!-- .slide: class="master02" -->

----

# MailRelay

<ul>
<li class="fragment">relays in batches
<li class="fragment">avoids duplicate sending
<li class="fragment">stores result in the DB
<li class="fragment">logs progress
<li class="fragment">is being reworked
</ul>

<!-- .slide: class="master02" -->

----

# OAuth

<ul>
<li class="fragment">built with Doorkeeper
<li class="fragment">scopes: email, name, with_roles
<li class="fragment">openid (OIDC-Token)
<li class="fragment">api (not widely used)
</ul>

<!-- .slide: class="master02" -->

----

# API

<ul>
<li class="fragment">via ServiceToken (non-personal)
<li class="fragment">via OAuthToken (personal)
<li class="fragment">JSON-API
</ul>

Note:
- ServiceToken is group-level and non-personal
- OAuthToken inherits your permissions and abilities

<!-- .slide: class="master02" -->

----

# API

<ul>
<li class="fragment">Groups
<li class="fragment">People in a Group
<li class="fragment">Events of a Group
<li class="fragment">MailingLists of a Group
</ul>

<!-- .slide: class="master02" -->

----

# The Technicalities

- Detailed Abilities
- MailingLists
- OAuth-Provider
- API

<!-- .slide: class="master02" -->

---

# Thank you

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

---

# Questions?
### &nbsp;

<img src="hitobito-slogan.png" alt="The Hitobito Logo">

<!-- .slide: class="master04 intro" -->

---

# Questions?

* https://hitobito.com
* https://puzzle.ch
* [Running in Production - Podcast 096](https://runninginproduction.com/podcast/96-hitobito-helps-you-manage-communities-with-complex-group-hierarchies)
* https://github.com/hitobito
* https://github.com/codez/wagons
* https://github.com/kronn

<!-- .slide: class="master04" -->

---

# Thanks, again

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

