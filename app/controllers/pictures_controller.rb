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
  
end
