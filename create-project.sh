#!/bin/sh

PROJECT_NAME=$1

if [ 'x' = "x$PROJECT_NAME" ]; then
  echo 'Supply a project name'
  exit 1
fi

if [ -e ./$PROJECT_NAME ]; then
  echo 'Project exists'
  exit 1
fi

cat << END > ./Gemfile
source 'http://rubygems.org'

gem 'foundation'
gem 'compass'
gem 'middleman'
gem 'haml'
END

bundle install
middleman init $PROJECT_NAME

SRC=$PROJECT_NAME/source

rm $SRC/index.html.erb
rm $SRC/images/*
rm $SRC/javascripts/*
rm $SRC/layouts/*
rm $SRC/stylesheets/*

echo 'set :haml, :format => :html5' >> $PROJECT_NAME/config.rb

foundation new tmp_foundation_site
mkdir -p $SRC/javascripts/lib
#cp -R tmp_foundation_site/images/* $SRC/images/
cp -R tmp_foundation_site/scss/* $SRC/stylesheets
cp -R tmp_foundation_site/bower_components/foundation/js $SRC/javascripts/lib/foundation
cp -R tmp_foundation_site/bower_components/foundation/scss/foundation $SRC/stylesheets/foundation
cp -R tmp_foundation_site/bower_components/foundation/scss/foundation.scss $SRC/stylesheets/
cp -R tmp_foundation_site/bower_components/jquery/jquery.js $SRC/javascripts/lib/jquery.js
cp -R tmp_foundation_site/bower_components/modernizr/modernizr.js $SRC/javascripts/lib/modernizr.js

mv $SRC/stylesheets/app.scss $SRC/stylesheets/site.css.scss

rm -rf tmp_foundation_site

cat << END > $SRC/javascripts/site.js.coffee
#= require lib/jquery.js
#= require lib/foundation/foundation.js
#= require lib/modernizr.js
END

cat << END >> $PROJECT_NAME/Gemfile

gem 'foundation'
END

cat << END > $SRC/layouts/layout.haml
!!!
/ paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
/[if lt IE 7] <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en">
/[if IE 7] <html class="no-js lt-ie9 lt-ie8" lang="en">
/[if IE 8] <html class="no-js lt-ie9" lang="en">
/ [if gt IE 8]><!
%html.no-js{:lang => "en"}
  / <![endif]
  %head
    %meta{:charset => "utf-8"}/
    / Set the viewport width to device width for mobile
    %meta{:content => "width=device-width", :name => "viewport"}/
    %title= data.page.title
    = javascript_include_tag "site.js"
    = stylesheet_link_tag "site.css"
    / IE Fix for HTML5 Tags
    /[if lt IE 9]
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  %body
    = yield
END

cat << END > $SRC/index.html.haml
---
title: My Super Awesome Site
---

/ Header and Nav
%nav.top-bar
  %ul.title-area
    / Title Area
    %li.name
      %h1
        %a{:href => "#"}
          Top Bar Title
    %li.toggle-topbar.menu-icon
      %a{:href => "#"}
  %section.top-bar-section
    / Left Nav Section
    %ul.left
      %li.divider
      %li.has-dropdown.not-click
        %a.active{:href => "#"} Main Item 1
        %ul.dropdown
          %li
            %label Section Name
          %li
            %a{:href => "#"} Dropdown Level 1
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li.divider
          %li
            %label Section Name
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li.divider
          %li
            %a{:href => "#"} See all &rarr;
      %li.divider
      %li
        %a{:href => "#"} Main Item 2
      %li.divider
      %li.has-dropdown.not-click
        %a{:href => "#"} Main Item 3
        %ul.dropdown
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li.divider
          %li
            %a{:href => "#"} See all &rarr;
      %li.divider
    / Right Nav Section
    %ul.right
      %li.divider
      %li.has-dropdown.not-click
        %a{:href => "#"} Main Item 4
        %ul.dropdown
          %li
            %label Section Name
          %li.has-dropdown.not-click
            %a{:href => "#"} Has Dropdown, Level 1
            %ul.dropdown
              %li
                %a{:href => "#"} Dropdown Options
              %li
                %a{:href => "#"} Dropdown Options
              %li.has-dropdown.not-click
                %a{:href => "#"} Has Dropdown, Level 2
                %ul.dropdown.test
                  %li
                    %a{:href => "#"} Subdropdown Option
                  %li
                    %a{:href => "#"} Subdropdown Option
                  %li
                    %a{:href => "#"} Subdropdown Option
              %li
                %a{:href => "#"} Subdropdown Option
              %li
                %a{:href => "#"} Subdropdown Option
              %li
                %a{:href => "#"} Subdropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li.divider
          %li
            %label Section Name
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li.divider
          %li
            %a{:href => "#"} See all &rarr;
      %li.divider
      %li
        %a{:href => "#"} Main Item 5
      %li.divider
      %li.has-dropdown.not-click
        %a{:href => "#"} Main Item 6
        %ul.dropdown
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li
            %a{:href => "#"} Dropdown Option
          %li.divider
          %li
            %a{:href => "#"} See all &rarr;
/ End Header and Nav
/ Main Grid Section
.row
  .large-3.columns
    .panel
      %h5 Panel Title
      %p This is a three columns grid panel with an arbitrary height.
  .large-6.columns
    .panel
      %h5 Panel Title
      %p This is a six columns grid panel with an arbitrary height. Bacon ipsum dolor sit amet salami ham hock biltong ball tip drumstick sirloin pancetta meatball short loin.
  .large-3.columns
    .panel
      %h5 Panel Title
      %p This is a three columns grid panel with an arbitrary height.
.row
  .large-6.columns
    .panel
      %h5 Panel Title
      %p This is a six columns grid panel with an arbitrary height. Bacon ipsum dolor sit amet salami ham hock biltong ball tip drumstick sirloin pancetta meatball short loin.
  .large-2.columns
    .panel
      %p
        %img{:src => "http://placehold.it/200x200"}/
  .large-4.columns
    .panel
      %h5 Panel Title
      %p This is a four columns grid panel with an arbitrary height. Bacon ipsum dolor sit amet salami.
.row
  .large-4.columns
    .panel
      %p
        %img{:src => "http://placehold.it/400x300"}/
  .large-4.columns
    .panel
      %p
        %img{:src => "http://placehold.it/400x300"}/
  .large-4.columns
    .panel
      %p
        %img{:src => "http://placehold.it/400x300"}/
.row
  .large-6.columns
    .panel
      %h5 Panel Title
      %p This is a six columns grid panel with an arbitrary height. Bacon ipsum dolor sit amet salami ham hock biltong ball tip drumstick sirloin pancetta meatball short loin.
  .large-3.columns
    .panel
      %h5 Panel Title
      %p This is a three columns grid panel with an arbitrary height.
  .large-3.columns
    .panel
      %h5 Panel Title
      %p This is a three columns grid panel with an arbitrary height.
/ End Grid Section
= partial 'footer'
END


cat << END > $SRC/_footer.haml
/ Footer
%footer.row
  .large-12.columns
    %hr/
    .row
      .large-6.columns
        %p &copy; Copyright no one at all. Go to town.
      .large-6.columns
        %ul.inline-list.right
          %li
            %a{:href => "#"} Section 1
          %li
            %a{:href => "#"} Section 2
          %li
            %a{:href => "#"} Section 3
          %li
            %a{:href => "#"} Section 4
END



cat << END > $SRC/config.yml
deploy:
  user: deploy
  host: mysuperawesomesite.com
  path: /var/www/apps/mysuperawesomesite/public
  port: 22
END

cat << END > $SRC/Rakefile
desc "builds the site and uses rsync to deploy the site to the server"
task :deploy do
  require 'yaml'
  config = YAML::load_file("config.yml")["deploy"]
  host = config["host"]
  path = config["path"]
  user = config["user"]
  port = config["port"]
  cmd = <<-CMD
    middleman build
    cd build
    rsync -rRzPL --rsh="ssh -p 30000" . #{user}@#{host}:#{path}
  CMD
  exec(cmd)
end
task :d => :deploy
END

echo "Project created in ./$PROJECT_NAME"
echo 'Build with `middleman build`'
echo 'Deploy with `rake deploy`'
