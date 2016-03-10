
json.array!(@events) do |event|
  json.extract! event, :id
  json.title event.description
  json.start event.startdate
  json.end event.enddate
  json.url project_task_url(@cur_proj,event, format: :html)
end