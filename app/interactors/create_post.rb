class CreatePost
  include Interactor

  before do
    set_user
    context.fail!(error: context.user.errors.full_messages) if context.user.errors.present?
    context.fail!(error: 'Required params: title, body, ip, user, login') unless required_params.all?(&:present?)
  end

  def call
    post = Post.create(title: context.title, body: context.body, ip: context.ip, user: context.user)
    context.fail!(error: post.errors) if post.errors.present?
    post.include_user = true
    context.post = post
  end

  private

  def set_user
    context.user = User.find_or_create_by(login: context.login)
  end

  def required_params
    [context.title, context.body, context.ip, context.login]
  end
end
