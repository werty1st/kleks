Spine = require('spine/core')
require('lib/spine-couch-ajax')

utils = require('lib/utils')

BaseModel = require('models/base')

class Site extends BaseModel
  @configure "Site", "_id", "name", "name_html", "tagline", "menu_html", "header_html", "footer_html", "link", "theme", "css", "seo_description", "seo_keywords", "google_analytics_code", "editor_email", "admin_email"
  
  @extend @CouchAjax
  
  @queryOn: ['name','tagline','_id']
    
  validate: ->
    return 'Site ID is required' unless @_id
    return 'Name is required' unless @name
    return 'Name HTML is required' unless @name_html

    # Validate the `_id` to be unique in the system
    if @isNew()
      found = Site.exists(@_id)
      return 'Site ID has been already used.' if found

    return false

module.exports = Site
