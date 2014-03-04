require 'xmlrpc/client'
class RMetaWebLog < XMLRPC::Client
  # Initialize RMetaWebLog with: host, path, port(optional), {options}
  #
  # RMetaWebLog.new("hostname", "/path/to/xmlrpc", {
  #   :blog_url => "http://path/to/blog",
  #   :blog_id => "blogid",
  #   :api_user => "username",
  #   :api_pass => "password"
  # })
  #
  # Optional parameters are:
  # +blog_url+ = 
  # +blog_id+ = 
  # +api_user+ = 
  # +api_pass+ = 
  # +proxy_host+ = 
  # +proxy_port+ = 
  # +user+ = 
  # +password+ = 
  # +use_ssl+ = 
  # +timeout+ = 
  
  def initialize(*args)
    options = extract_hash_from_args!(args)
    args[2] ||= 80
    @blog_url = options[:blog_url]
    @blog_id = options[:blog_id]
    @api_user = options[:api_user] 
    @api_pass = options[:api_pass]
    super(args[0], args[1], args[2], options[:proxy_host], options[:proxy_port], options[:user], options[:password], options[:use_ssl], options[:timeout])
  end
  
  #Returns Hash.	
  def post(postid)
    call('metaWeblog.getPost', postid, @api_user, @api_pass)	  
  end

  #Returns Hash.
  def posts(count = 5)
    call('metaWeblog.getRecentPosts', @blog_id, @api_user, @api_pass, count)
  end

  #Returns True. 
  def delete_post!(postid)
    call('metaWeblog.deletePost', "appkey", postid, @api_user, @api_pass, true)	  
  end


  #Returns String (postid). 
  def new_post(title, content)
    object = { 'title' => title, 'link' => @blog_url, 'description' => content }
    call('metaWeblog.newPost', @blog_id, @api_user, @api_pass, object, true)
  end

  #Returns True. 
  def edit_post(postid, title, content)
    object = { 'title' => title, 'link' => @blog_url, 'description' => content }
    call('metaWeblog.editPost', postid, @api_user, @api_pass, object, true)
  end

  #Returns Hash. 
  def new_media_object(name, type, filename)
  require 'base64'
    object = {
      'name' => name,
      'type' => type,
      'bits' => XMLRPC::Base64.new(File.read(filename)) 
    }
    call('metaWeblog.newMediaObject', @blog_id, @api_user, @api_pass, object)
  end

  #Returns Hash.
  def categories
    call('metaWeblog.getCategories', @blog_id, @api_user, @api_pass)
  end

  #Returns array of hashes. 
  def recent_posts(number = 5)
    call('metaWeblog.getRecentPosts', @blog_id, @api_user, @api_pass, number)
  end
  
  private

  def extract_hash_from_args!(args)
    args.last.is_a?(Hash) ? args.pop : {}
  end
  
end
