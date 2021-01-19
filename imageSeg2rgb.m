function image = imageSeg2rgb(real,binary)
[b,k] = size(binary);
A = zeros(b,k,3);

for i=1:b
    for j=1:k
        if binary(i,j) == 1
            A(i,j,:) = real(i,j,:);
        end
    end
end
image = uint8(A);
end