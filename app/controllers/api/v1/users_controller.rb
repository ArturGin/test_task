class Api::V1::UsersController < Api::V1::ApplicationController
  def ip_list
    render json: ips, status: :ok
  end

  private

  def ips
    User.all.joins(:posts).select('users.login, posts.ip as ip')
        .group_by(&:ip).to_a
        .map { |i| { ip: i.first, logins: i.second.map(&:login) } }
  end
end
