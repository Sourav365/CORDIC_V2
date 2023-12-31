# CORDIC_V2

**Latency/Output will be available after "Number of CORDIC Stages" clk cycle.**

**After "Number of CORDIC Stages", Throughput = 100% --> output will come at every clk cycle. (As it is pipelined)**

**Everything is scaled by ```x 'd100``` (Decimal value is multiplied by 100)**

*** ***Here everything is done for 1st quadrant only***
## Rotation Mode output
*** Only for output at 1st quadrant

![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/916ca9a9-2b41-4eed-a217-3a1f2561b3de)


## Vectoring Mode output
*** Only for points at 1st quadrant

1. Y_REF = 0
![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/05943814-6c49-487a-a9a5-7903c95da2b4)

1. X_REF = 0
![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/9e3d9122-652e-4cb2-9919-fe57d27a8aca)

## Applications

```
// For clk-wise rotation
xf =  x0 cos(θ) + y0 sin(θ)
yf = -x0 sin(θ) + y0 cos(θ)
```
### 1. Calculate sin(θ) & cos(θ) 

***Assuming θ in 1st quadrant --> Clk-wise rotation
```
If, x0 = 0, y0 = 1
Then, xf = sin(θ)
      yf = cos(θ)
```
![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/b9ec5ba5-902c-42a8-8cc5-1c7be6059343)

![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/3f58e2dd-6e99-4cdf-9cca-4f8c69945a3e)

### 2. Calculate distance between two points (x1,y1) and (x2, y2)

 $L=\sqrt{(x_2-x_1)^2+(y_2-y_1)^2}=\sqrt{x^2+y^2}$

![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/b3065cc2-5521-4b90-9761-f117646fd193)

![image](https://github.com/Sourav365/CORDIC_V2/assets/49667585/4a58ebf2-2c80-4887-afb4-aa3a8f6bfe56)


 ### 3. Calculation of fraction number/ invert
 $\frac{x}{z} = \frac{z.cos(θ)}{z}=cos(θ)$

 As, mod(cos(θ)) <= 1, so, it'll work for x<z only.

 
