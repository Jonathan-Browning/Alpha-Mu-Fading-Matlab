classdef AlphaMu
    %ALPHAMU This class holds all the parameters for the \alpha-\mu fading model.
    % It calculates theoretical envelope PDF
    % It does a Monte Carlo simulation using the parameters
    
    properties(Constant, Hidden = true)
        NumSamples = 2E6; % number of samples
        r = 0:0.001:6 % envelope range for PDF ploteter
    end 
    
    properties(Access = public)
        alpha; % nonlinearity parameter
        mu; % number of clusters
        r_hat; % root mean square of the signal
    end
    
    properties(Hidden = true) 
        multipathFading; % Found based on the inputs
        envelopeProbability; % Calculated theoretical envelope probability
        xdataEnv; % Simulated envelope density plot x values 
        ydataEnv; % Simlated envelope density plot y valyes
    end
    
    methods(Access = public)
        function obj = AlphaMu(alpha,mu,r_hat)
            %ADDITIVESHADOWRICE Construct an instance of this class
            
            %   Assigning input values
            obj.alpha = input_Check(obj,alpha,'\alpha',1,10);
            obj.mu = input_Check(obj,mu,'\mu',1,10);
            obj.r_hat = input_Check(obj,r_hat,'\hat{r}^2',0.5,2.5);
            
            % other calculated properties
            obj.multipathFading = Multipath_Fading(obj);
            obj.envelopeProbability = envelope_PDF(obj);
            [obj.xdataEnv, obj.ydataEnv] = envelope_Density(obj);
        end
    end
    
    methods(Access = private)
        
        function data = input_Check(obj, data, name, lower, upper) 
            % intput_Check checks the user inputs and throws errors
            
            % checks if input is empty
            if isempty(data)
                error(strcat(name,' must be a numeric input'));
            end
            
            % inputs must be a number
            if ~isnumeric(data)
               error(strcat(name,' must be a number, not a %s.', class(data)));
            end
            
            % input must be within the range
            if data < lower || data > upper
               error(strcat(name,' must be in the range [',num2str(lower),', ',num2str(upper),'].'));
            end
            
            % mu must be integer
            if (strcmp(name,'\mu') || strcmp(name,'\alpha')) && mod(data, 1) ~= 0
                error(strcat(name,' must be an integer'));
            end
                
        end
        
        function [sigma2] = scattered_Component(obj)
            %scattered_Component Calculates the power of the scattered 
            %signal component.    
            
            sigma2 = obj.r_hat.^(obj.alpha) ./(2 * obj.mu);
            
        end
        
        function [gaussians] = generate_Gaussians(obj, sigma) 
            %generate_Gaussians Generates the Gaussian random variables 
            
            gaussians = normrnd(0,sigma,[1,obj.NumSamples]);
        end
        
        function [multipathFading] = Multipath_Fading(obj) 
            %complex_MultipathFading Generates the random fading
            
            [sigma2] = scattered_Component(obj);
            
            multipathFading = 0;
            for i = 1 : 1 : obj.mu
                X_i = generate_Gaussians(obj, sqrt(sigma2));
                Y_i = generate_Gaussians(obj, sqrt(sigma2));

                multipathFading = multipathFading + X_i.^(2) + Y_i.^(2);
            end 
            
        end    
        
        function [eProbTheor] = envelope_PDF(obj)
            %envelope_PDF Calculates the theoretical envelope PDF
             
            A = obj.alpha.*obj.mu^(obj.mu).*obj.r.^((obj.alpha*obj.mu)-1);
            B = obj.r_hat^(obj.alpha*obj.mu)*gamma(obj.mu);
            C = exp(-obj.r.^(obj.alpha)*obj.mu./(obj.r_hat^(obj.alpha)));
            eProbTheor = (A ./ B) .* C;
        end
        
        function [xdataEnv, ydataEnv] = envelope_Density(obj)
            %envelope_Density Evaluates the envelope PDF
            R = nthroot(obj.multipathFading,obj.alpha);

            [f,x] = ecdf(R);
            [ydataEnv, xdataEnv] = ecdfhist(f,x, 0:0.05:max(obj.r));
            
        end
            
    end
    
end
