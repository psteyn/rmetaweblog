rmetaweblog
===========

A ruby class for interacting with the MetaWebLog API used by many blogging systems.
https://rubygems.org/gems/rmetaweblog/versions/1.0

Installing:
-----------

gem install rmetaweblog


Full example
------------


```ruby
require 'rmetaweblog'

#This is an example to interact with the Apache Roller java based blogging application:

#Initialize RMetaWebLog with: host, path, port(optional), {options}

blog = RMetaWebLog.new("hostname", "/roller/roller-services/xmlrpc", {
        :blog_url => "http://hostname:8080/roller/blogname",
        :blog_id => "blogid",
        :api_user => "username",
        :api_pass => "password"
        })

#Upload an image

img_url = blog.new_media_object("filename.jpg", "image/jpeg", "/location/of/filename.jpg")

#img_url in now in this case: http://hostname:8080/roller/blogname/resource/filename.jpg 

#Create a new post to blog

blog.new_post("title","content")

#Most of class methods work in the same manner, just look at the class if you want to do anything else.
```
