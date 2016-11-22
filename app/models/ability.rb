class Ability
  include CanCan::Ability
# cancancan expects a method in controller called current_user
# user will call current_user in application controller, shouldn't call it unless you have a current_user
  def initialize(user)
  # :manage referes to any operation, so this means that the owner user can do everything
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all?
    end

    alias_action :edit, :update, :destroy, :to => :modify

# only want the people who modified the post to be able to edit, update and destroy
    can :modify, Post do |p|
      # can is the action you are giving the user permission to do
      # specific instance of the class by doing |p|
      p.user == user
      #post has to have a user if nil will crash
    end

    can :manage, User do |u|
      u  == user
      # user in the view
      # session id matches url/21 id


    end

    can :modify, Comment do |c|
      c.user == user || c.post.user == user

      # can manage if the post is made by the current user or if the user who made that comment is the current user

      # if you are the user who made the post you can delete the comment as well(higher order)

      # c.user is just an asocciation because you made that association in the model
    end



  end



end


    # manage: refers to doing any action on the post, comment, etc object: :read, :delete, :edit, :update..etc


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
