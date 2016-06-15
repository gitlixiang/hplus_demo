#确定csv文件目录
require 'csv'
directory = File.join(Rails.root, 'db/csv_data')

ActiveRecord::Base.connection_pool.with_connection do |c|
  name = 'hr_ent_talents'
  puts "truncating...#{name}"
  c.execute("truncate table #{name}")
  CSV.foreach(directory+'/'+name+'.csv', headers:true) do |row|
    obj = Hr::EntTalent.new row.to_hash.merge!({'created_at'=>'2013-12-10 11:18:40', 'updated_at'=>'2013-12-10 11:18:40'})
    obj.save(validate: false)
  end

  first_name = %w(王 李 张 刘 陈 杨 黄 吴 赵 周
  徐 孙 马 朱 胡 林 郭 何 高 罗
  郑 梁 谢 宋 唐 许 邓 冯 韩 曹
  曾 彭 萧 蔡 潘 田 董 袁 于 余
  叶 蒋 杜 苏 魏 程 吕 丁 沈 任
  姚 卢 傅 钟 姜 崔 谭 廖 范 汪
  陆 金 石 戴 贾 韦 夏 邱 方 侯
  邹 熊 孟 秦 白 江 阎 薛 尹 段
  雷 黎 史 龙 陶 贺 顾 毛 郝 龚
  邵 万 钱 严 赖 覃 洪 武 莫 孔)
  man_name = %w(祥旭 东慧 品希 韦明 大镇 禹西 大鹏 禹希 亮伟 劲柏 恒盛 品西 柏升 洵 华 诚 芒霖 柳宏 品正 宵峰 志敏 彦缘 楗宏 建宏 冠如 冠希 坚宏 鸿涛 思语 笑生 金冰 籽菡 素言 二方 咏缨 垂旭 芝驿 小俊 思漫 振东 俊锋 奕玮 佳慧 绍兵 科 烁宇 奕衡 国安 谱月 绘月 绘冰 绘帆 猎帆 橹帆 丽帆 丽霏 觉霏 识霈 韫霈 韫霏 韵霏 觉蒙 识蒙 敏榕 艳娇 勇桦 紫辉 雨梦 雨帆 泉 泉崎 泉一 一帆 禹衡 露田 佩宇 景楠 凤 鼎夫 文清 元舒 宁 鑫 力齐 优璇 鸣 吟春 建宁 大衍 志强 衍 恋萱 浩铭 俊明 浩明 友贤 铭润 禹霖 一铭 小孩 瑜 恺 思鹏 昱吟 海龙 劲材 亚利 昌明 昆朋 志斌 丽静 志立 叙潼 天成 文果 桐 宫 谭旺 秋航 文杰 子昂 勇鑫 扬帆 湖鑫 楚雯 铭煊 楚楚 铎坤 军 清鑫 优佳 文友 勇 昭席 优优 芯琦 坤锋 芯琪 昆锋 亮钧 铭烯 祥汝 祥雨 爻煊 建楠 日升 国建 建权 嘉齐 帮秀 建析 公伯 建机 志铎 碧如 璐璐 嘉杰 曦杨 曦晴 炫郡 殿阳 文惠 培源 曦 仁忠 烁冰 谶 俊希 曦祧 峰 宸 雪擂 浩尔 铖 义炎 佃阳 柽 俊杰 益逸 慎 升 曦珧 艺慧 兢 荩 炫锦 蔷 丽华 冻 桂健 胨 瑗 思雨 耀 施松 珅淼 珧 菲 绯 佳绪 冠 露熠 俊 峰峰 舒铭 泫雨 舒旻 寿鸿 飞 金龙 飞耀 沸耀 峰耀 凤骏 奕璇 嘉 鑫龙 耀平 夏 洛诗 鹏宇 建成 耀川 耀冰 薇薇 耀斌 薇琦 径川 耀峰 耀浣 钦兰 艺豪 耀桓 芯蓓 耀欢 耀缓 耀和 耀河 南州 耀菏 耀言 彦欣 耀滟 耀飞 锶蓓 耀窑 思蓓 耀震 登丰 耀正 韵旭 耀真 耀针 盛隆 耀振)
  # 270
  woman_name = %w(嫣然 琪琳 妍然 译文 冠文 娟 红霞 怡伊 红 思洁 治文 丽蓉 泓文 丽 桂花 红梅 泉娅 怡颖 琼 琼霞 书悦 敬文 谭文 悦田 基文 美 春红 成美 和妹 玥希 碧茹 曦婷 骊颖 曦瑶 丽娜 博文 肖霞 洛婷 芯茹 帅颖 耀萍 思颖 耀瑶 娅楠 海霞 妙霞 淑霞 小文 娟琳 丽媛 绍颖 景文 水萍 泳洁 延红 艳萍 彦红 嫣 宣丽 倩 玥秀 宣美 宣怡 宣婵 心琴 玥州 宣娟 宣玲 宣婷 玲 宣颖 倩倩 宣玉 小丽 春燕 秋霞 诗媛 韵玲 怡彤 怡冰 昱颖 怡静 怡萱 昭文 妍涵 凤梅 婉玉 怡帆 泊文 彩燕 泓颖 亭燕 茹羽 娜 星婷 桂芬 妍 丽霞 馥蓉 泓玲 爱霞 子洁 泓婧 紫洁 萍 敏燕 国萍 钰瑶 娟梅 兰萍 嘉悦 泮玥 海燕 鹤玉 续莉 续丽 丽花 怡婷 怡 姹艳 花 文莉 琼娜 瑛 启瑶 伟丽 玮莉 惠瑶 紫瑶 小红 紫颖 紫莹 宝莹 宝瑛 见红 建红 艳 秀红 志媛 诗燕 潇燕 妍铮 丽萍 美文 艳琳 文琳 凤文 怡宁 美红 姿瑶 玥瑶 玥如 彦瑶 军燕 贞颖 凯颖 妙妍 士玉 嵋文 韵婷 绮婷 铭婷 丹萍 嫣冉 雪娜 春丽 妍静 美蓉 奕文 小美 凡冉 惠萍 力文 淑萍 诗茹 心茹 忠霞 梓文 露瑶 妍秋 丽丽 玥孜 伟文 盈洁 娅如 桂芳 品文 春萍 怡君 湘婷 益洁 淳萍 怡伶 宝洁 丹婷 蔓丽 丽娟 柳燕 惠洁 怡兰 妍希 妍熹 丽莉 桂红 莉萍 芳 摅颖 家娟 娜冰 霞坤 镜文 彩霞 咏艳 娜芸 祖芬 悦红 鸣梅 钰婷 金燕 怡可 杰妹 怡青 益妹 衍芳 支梅 丽芳 书妹 华妹 恬美 桂丽 英妹 虹萍 鹰妹 施红 涓莹 思丽 扬文 小萍 思琳 玥霖 思媛 思玥 思玲 莎茹 韵文 娅玲 玲珑 怡燕 怡霏 月婷 珏怡 余颖 怡然 洲琳 宝怡 建萍 玲利 红琳 怡薇 真文 琳慧 悦汶 妍宏 萍萍 思悦 凌悦 灵悦 国燕 倩萍 美琴)

  sex = Proc.new { %w(M M F)[rand(0..2)] }
  birthday = Proc.new { Time.now.change(year: rand(1970..1995), month: rand(1..12), day: rand(1..28)) }
  name = Proc.new { |sex| sex=='M' ? first_name[rand(0..99)] + man_name[rand(0..254)] : first_name[rand(0..99)] + woman_name[rand(0..269)] }

  Nationality = Fdn::Lookups::Nationality.all.map(&:code)
  national_code = Proc.new { Nationality[rand(0..Nationality.size)] }

  education = Proc.new { rand(1..6) }
  type_code = Proc.new { rand(1..4) }
  ent_id = Proc.new { rand(1..5) }

  100.times do
    obj = Hr::EntTalent.new(ent_id:ent_id.call, sex: (s = sex.call),name: name.call(s),birthday: (b=birthday.call),work_date:b+20.years,
    national_code: national_code.call, education: education.call, type_code: type_code.call, status: 'Y', native_place_code: '浙江嘉兴')
    obj.save(validate: false)
  end


  puts "load completed...#{name}"
end