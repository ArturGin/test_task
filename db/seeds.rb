if Rails.env.development?
  ips = (0..50).to_a
  logins = (0..100).to_a
  200000.times do
    HTTParty.post('http://localhost:3000/api/v1/posts', body: {
                                                               login: logins.sample.to_s, 
                                                               body: SecureRandom.hex(5), 
                                                               title: SecureRandom.hex(5),
                                                               ip: ips.sample.to_s
                                                               })
  end
  request =  HTTParty.get('http://localhost:3000/api/v1/posts').parsed_response
  total = request['meta']['total_count']
  posts =  HTTParty.get("http://localhost:3000/api/v1/posts?limit=#{total}").parsed_response['posts']
  posts.each_with_index do |value, index|
    HTTParty.post("http://localhost:3000/api/v1/posts/#{value['id']}/ratings", body: {user_id: posts[index + 1]['user']['id'], value: rand(1..5)}) 
  end
end