class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :user, :is_done

  # TODO:あとで調べる
  def user
    instance_options[:without_serializer] ? object.user : UserSerializer.new(object.user, without_serializer: true)
  end
end
