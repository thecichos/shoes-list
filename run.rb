require "rubygems"
require "json"
require "green_shoes"

Shoes.app width: 600 do
  file = File.read("json/cars.json")
  fileParsed = JSON.parse(file)

  make_list = []
  model_list = []
  interval_value = 0
  while interval_value != fileParsed.length
    if make_list.include? fileParsed[interval_value]["make"]

    else
      make_list.push(fileParsed[interval_value]["make"])
    end
    interval_value = interval_value + 1
  end
  choice1 = ""
  choice2 = ""
  @make_list_choice = para

  flow margin: 10 do
    @make_list = list_box items: make_list do |e|
      choice1 = e.text
      @make_list_choice.text = "#{choice1} #{choice2}"
      interval_value = 0
      while interval_value != fileParsed.length
        if fileParsed[interval_value]["make"] == e.text
          @model_list.items = fileParsed[interval_value]["models"]
        end

        interval_value = interval_value + 1
      end
      re = @model_list.items
      @model_list.choose re[0]
    end
  end
  flow margin: 10 do
      @model_list = list_box items: model_list do |e|
      choice2 = e.text
      @make_list_choice.text = "#{choice1} #{choice2}"
    end
  end
  re = @make_list.items
  @make_list.choose re[0]
  re = @model_list.items
  @model_list.choose re[0]
end
