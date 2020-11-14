# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge
      # grant_on 'users#create', badge_id: 7, badge: 'just-registered', to: :itself
      # grant_on 'registrations#create', badge_id: 7, badge: 'just-registered', to: :itself possibly for devise

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end

      # if the user has the first perfect play of a particular game, grant badge

      # generals

      grant_on 'users#profile', model_name: 'User', badge: 'signed_up', to: :action_user

      grant_on 'contact#send_message', badge: 'first_contact', to: :action_user

      # check application controller for additional rules

      # generals

      # stats

      grant_on 'plays#create', badge: 'made_first_rank', to: :user do |play|
        User.top_users.first == play.user
      end

      grant_on 'plays#create', badge: 'made_second_rank', to: :user do |play|
        User.top_users.second == play.user
      end

      grant_on 'plays#create', badge: 'made_third_rank', to: :user do |play|
        User.top_users.third == play.user
      end

      # stats


      conversations_rules = [
        {
          badge: 'first_post',
          model_name: 'Post',
          rule: 'resource.user.posts.count == 1',
          grant_on: 'posts#create'
        },
        {
          badge: 'tenth_post',
          model_name: 'Post',
          rule: 'resource.user.posts.count == 10',
          grant_on: 'posts#create'
        },
        {
          badge: 'hundredth_post',
          model_name: 'Post',
          rule: 'resource.user.posts.count == 100',
          grant_on: 'posts#create'
        },
        {
          badge: 'first_comment',
          model_name: 'Comment',
          rule: 'resource.user.comments.count == 1',
          grant_on: 'comments#create'
        },
        {
          badge: 'tenth_comment',
          model_name: 'Comment',
          rule: 'resource.user.comments.count == 10',
          grant_on: 'comments#create'
        },
        {
          badge: 'hundredth_comment',
          model_name: 'Comment',
          rule: 'resource.user.comments.count == 100',
          grant_on: 'comments#create'
        },
        {
          badge: 'first_message',
          model_name: 'Message',
          rule: 'resource.user.messages.count == 1',
          grant_on: 'messages#create'
        },
        {
          badge: 'tenth_message',
          model_name: 'Message',
          rule: 'resource.user.messages.count == 10',
          grant_on: 'messages#create'
        },
        {
          badge: 'hundredth_message',
          model_name: 'Message',
          rule: 'resource.user.messages.count == 100',
          grant_on: 'messages#create'
        }
      ]

      conversations_rules.each do |rule_hash|
        grant_on rule_hash[:grant_on], badge: rule_hash[:badge], to: :user, model_name: rule_hash[:model_name] do |resource|
          eval(rule_hash[:rule])
        end
      end

      Language.all.pluck(:language_code).each do |language_code|
        path = Rails.root.join("app/assets/images/badges/games/perfect_plays/#{language_code}")

        filenames = Dir.children(path).map { |e| e.split('.') }
        filenames.each do |fname|
          grant_on 'plays#create', badge: fname[1], to: :user do |play|
            play.perfect? && play.game.slug == fname[0] && play.game.language.language_code == language_code
          end
        end
      end
    end
  end
end
