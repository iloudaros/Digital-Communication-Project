function code = jhuffmanenco(input,dict)
% Author: Ioannis Loudaros, ΑΜ:1067400

input_size = height(input); % Πλήθος Χαρακτήρων 

input = num2cell(input); % Μετατρέπουμε το input σε cell array ώστε να μπορούμε να αντικαταστήσουμε κατευθείαν τον κάθε χαρακτήρα με το huff του

for i = 1:height(input) % Μετατρέπουμε τον κάθε χαρακτήρα στο huff του
    input{i} = dict(input{i});
end

code = cell2mat(input')'; % Ενώνουμε τα cells σε ένα Array που είναι το ζητούμενο 

end