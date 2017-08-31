#!/usr/bin/env ruby

require "optparse"

executable = nil
args = []

parser = OptionParser.new do |opt|
  opt.on("-e EXECUTABLE", "--exec EXECUTABLE", "specify executable") do |e|
    exeutable = e
  end

  opt.on("-a ARG", "--argument ARG", "Provide single argument") do |a|
    args << a
  end

  opt.on("--", "Every following argument should be passed to the program") do
    args << ARGV
    opt.terminate
  end
end

parser.parse!

if !executable
  Dir.entries(Dir.pwd).each do |f|
    if File.executable?(f) and not File.directory?(f)
      exec("./#{f} #{args.join(" ")}")
    end
  end
else
  if not File.directory?(executable)
    if File.executable?(executable)
      exec("./#{executable} #{args.join(" ")}")
    else
      exec("chmod +x #{executable}; ./#{executable} #{args.join(" ")}; chmod -x #{executable}")
    end
  end
end


