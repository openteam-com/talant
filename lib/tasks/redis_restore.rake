desc 'restore redis data'

task :redis_restore => :environment do
  Event.find_each do |event|
    event.related_items.each do |item|
      prefix = item.item_type
      id = item.item_id

      $redis.set "#{prefix}_#{id}", open(URI.encode("http://znaigorod.ru/api/single_#{prefix}?id=#{id}")).read rescue item.destroy
    end
  end
end
