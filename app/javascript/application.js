// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import "flowbite"

import Sortable from 'sortablejs'
window.Sortable = Sortable

import "./channels"
