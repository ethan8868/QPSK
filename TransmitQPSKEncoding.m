wordstring = 'beees';
    doubles = double(wordstring);
    binary = (dec2bin(doubles));
    
    binary = binary -'0';
    
    [rowbin,colbin] = size(binary);
    
    I = binary(:,1:2:end); % odds --> cos
    Q = binary(:,2:2:end); % evens --> sin
   
    I( I == 0) = -1;
    Q( Q == 1) = j;
    Q( Q == 0) = -j;
    Q = [Q j*ones(rowbin,1)];
    
    totalmatrix = I + Q;
    totalresult = flipud(rot90(totalmatrix));

    [rowtotal,coltotal] = size(totalresult)
    
    data = reshape(totalmatrix, rowtotal*coltotal,1);
    
%     address='30C628D';
%    tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9,'InterpolationFactor',256,'MasterClockRate',1.5*32000000);

    p = 0.5*ones(100,1);

    data2 = repmat(data,10,1); % lengthens matrix
    dat_us = upsample(data2,100); % to prevent switching too fast    
    tmp = conv(dat_us,p); % to make an actual square wave
    x = zeros(1e3+length(tmp),1);
    x(1e3+1:end)=tmp;
    step(tx,x);
