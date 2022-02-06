
initial_weights_n1 = [ 1 0 0 1 2; 0 3 2 3 0; 2 2 1 3 3; 1 3 0 0 2; 3 1 1 0 1 ]
initial_weights_n2 = [ 0 2 3 0 1; 2 0 2 0 0; 1 2 3 1 2; 0 1 1 0 1; 2 3 1 3 0 ]


learnt_n1 = [0 0 0 0 1; 0 3 3 3 0; 1 3 0 3 2; 0 3 3 3 1; 2 0 0 0 0 ] 
learnt_n2 = [0 3 3 0 0; 1 0 3 0 0; 0 1 3 0 1; 0 0 3 0 0; 1 3 3 3 0 ]

figure(1);
imagesc(learnt_n1)
colormap(flipud(gray))

figure(2);
imagesc(learnt_n2)
colormap(flipud(gray))

figure(3);
imagesc(initial_weights_n1)
colormap(flipud(gray))

figure(4);
imagesc(initial_weights_n2)
colormap(flipud(gray))
