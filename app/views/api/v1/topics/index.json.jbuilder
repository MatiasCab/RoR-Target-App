json.topics @topics do |topic|
    json.partial! 'info', topic:
end