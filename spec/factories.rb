FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :invalid_user, parent: :user do
    name nil
  end

  factory :story do
    title "Story Title"
    description "Story Description"
    state "new"
    user
  end

  factory :invalid_story, parent: :story do
    title nil
  end

  factory :story_comment do
    content "Comment content"
    story
    user
  end

end