class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :department, :password, :email_address

  def department
    # あぁ～三項演算子か
    instance_options[:without_serializer] ? object : DepartmentSerializer.new(object.department, without_serializer: true)
end
