function ref = DLCReference(X, vx, vxRef, Ts, N, vehicle)
    
    X_along_horizon = linspace(X, X+vx*N*Ts, N+1);
    % in the event that vx is vastly different from vxRef, the distance
    % interval generated by this DLCRef function will be changing over
    % time.
    
    shape = 2.4;
    dx1 = 25;
    dx2 = 21.95;
    dy1 = 4.05;
    dy2 = 5.7;
    Xs1 = 27.19;
    Xs2 = 56.45;
    offset = 5;

    % along horizon (shape formula)
    z1 = shape/dx1*(X_along_horizon - offset - Xs1) - shape/2;
    z2 = shape/dx2*(X_along_horizon  - offset - Xs2) - shape/2;

    YawRef = atan( dy1*(1./cosh(z1)).^2*(1.2/dx1) - dy2*(1./cosh(z2)).^2*(1.2/dx2));
    YRef = dy1/2*(1+tanh(z1)) - dy2/2*(1+tanh(z2));

    ref = [vxRef*ones(1,N+1);   % vx reference
           zeros(1,N+1);    % vy reference
           YawRef;
           zeros(1,N+1);    % yaw rate reference
           vxRef/vehicle.frontAxle.Rw * ones(1,N+1);    % omega_f reference
           vxRef/vehicle.rearAxle.Rw * ones(1,N+1);     % omega_r reference
           YRef];   % y reference

end