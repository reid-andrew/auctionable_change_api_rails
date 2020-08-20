class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :email, if: proc { |record| record.id }
  attributes :error, if: proc { |record| !record.id }
end
