% Activation Function - Sigmoid with slope 1/k and threshold
% @param x: vector of inputs that need to be converted into vector of activity
% @param sigmoid_k: k value that defines the slope of sigmoid function (slope = 1/k)
% @param sigmoid_thresh: threshold for sigmoid function (translates function left or right)
% @output rate: vector of activity
function rate = sigmoid_func(x, sigmoid_k, sigmoid_thresh)
    rate = 1./(1+exp(-(x-sigmoid_thresh)/sigmoid_k));
end