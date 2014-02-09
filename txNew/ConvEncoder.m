function out = ConvEncoder(inBits)
encoded = rem(conv2(inBits,[1 0 1 1 0 1 1;1 1 1 1 0 0 1;]),2);
out = encoded(1:end-12);