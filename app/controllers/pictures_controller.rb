class PicturesController < ApplicationController
  def recent
    @photos = Photo.all.order({ :created_at => :desc }).limit(25)

    render("pic_templates/time_list.html.erb")
  end

  def most_liked
    @photos = Photo.all.order({ :likes_count => :desc }).limit(25)

    render("pic_templates/liked_list.html.erb")
  end

  def show_details
    photo_id = params.fetch("some_id")

    @pic = Photo.where({ :id => photo_id }).at(0)
    
    @all_users = User.all.order({ :username => :asc })

    render("pic_templates/details.html.erb")
  end
  
  def byyyeee
    pic_id = params.fetch("id_to_delete")
    picture = Photo.where({:id => pic_id}).at(0)
    
    picture.destroy
    
    redirect_to("/popular")
  end 
  
  def blank_form 
    @all_users = User.all.order({ :username => :asc })
    render("pic_templates/new_form.html.erb")
  end
  
  def save_new_row
    p = Photo.new
    p.image = params.fetch("pic_image")
    p.caption = params.fetch("pic_caption")
    p.owner_id = params.fetch("poster_id")
    
    p.save
    
    redirect_to("/recent")
  end
  
  def prefilled_form
    pic_id = params.fetch("id_to_update")
    
    @photo = Photo.where({ :id => pic_id }).at(0)
    
    render("pic_templates/edit_form.html.erb")
  end 

  def update_record
    photo_id = params.fetch("photo_id")
    
    up_pic = Photo.where({:id => photo_id}).at(0)
    up_pic.image = params.fetch("pic_image")
    up_pic.caption = params.fetch("pic_caption")
    up_pic.save 
    
    redirect_to("/photos/" + photo_id)
  end



  def add_comment
    pic_id = params.fetch("<strong>picture_id</strong>")
    @pic = Photo.where({:id => pic_id}).at(0)

    p = Comment.new
    p.author_id = params.fetch("commenter_id")
    p.body = params.fetch("comment_caption")
    p.photo_id = pic_id

    p.save

    redirect_to("/photos/" + pic_id)

  end

end
