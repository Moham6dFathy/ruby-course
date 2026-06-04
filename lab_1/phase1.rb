
puts 'How many scores?'
scores_nums = gets.chomp.to_i

scores = []
for i in 1..scores_nums do
    ok = true;
    while ok do
        puts "Enter score #{i}:"
        score = gets.chomp.to_f
        if score >= 0 && score <= 100
            scores << score
            ok = false
        else
            puts "Invalid score. Please enter a score between 0 and 100."
        end
    end
end

highest_score = scores.max
minimum_score = scores.min
avg_score = scores.sum / scores.size.to_f

grade = case avg_score 
when 90..100
    'A'
when 80...90
    'B'
when 70...80
    'C'
when 60...70
    'D'
else 
    'F'
end

puts "Results:
  Average : #{avg_score}
  Grade   : #{grade}
  Highest : #{highest_score}
  Lowest  : #{minimum_score}"