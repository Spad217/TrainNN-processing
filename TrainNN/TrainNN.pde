class Neyron {
  Neyron[] child = null;
  double[] weight;
  double learnRate = 0.1;

  Neyron(Neyron[] child_, double[] weight_) {
    child = child_;
    weight = weight_;
  }

  Neyron(Neyron[] child_) {
    child = child_;
    weight = new double[child.length];
    for (int i = 0; i < weight.length; i++)
      weight[i] = random(-1, 1);
  }

  Neyron(int n_child, double[] weight_) {
    weight = weight_;
  }

  Neyron(int n_child) {
    weight = new double[n_child];
    for (int i = 0; i < weight.length; i++)
      weight[i] = random(-1, 1);
  }

  double probe(double[] x) {
    double sum = 0;
    if (child == null) {
      for (int i = 0; i < x.length; i++) {
        sum += x[i] * weight[i];
      }
    } else {
      for (int i = 0; i < child.length; i++) {
        sum += child[i].probe(x) * weight[i];
      }
    }
    return funcActiv(sum);
  }

  double funcActiv(double x) {
    return 1 / (1 + exp((float)-x));
  }

  void train(double[] x, double correct, boolean isFirst) {
    double out = this.probe(x);
    double delWeight = correct;
    if (isFirst) {
      delWeight = (out - correct) * out * (1 - out);
    }
    if(child != null){
    for (int i = 0; i < weight.length; i++) {
      weight[i] -= child[i].probe(x) * delWeight * learnRate;
      child[i].train(x, weight[i] * delWeight, false);
      }
    } else {
      weight[i] -= x[i] * delWeight * learnRate;
    }
  }
}

class Test {
  double[] input;
  double[] correct;
  Neyron[] output;
  Test(double[] input_, double[] correct_, Neyron[] output_){
    input = input_;
    correct = correct_;
    output = output_;
  }

  void train(){
    for(int i = 0; i < output; i++)
      output[i].train(input, correct[i], true);
  }
}

Neyron[] hiddenLayer1 = {new Neyron(4), new Neyron(4), new Neyron(4)};
Neyron[] hiddenLayer2 = {new Neyron(hiddenLayer1), new Neyron(hiddenLayer1)};
Neyron[] output = {new Neyron(2)}
Test[] tests = {new Test(new double[]{1,0,1,1}, new double[]{1}, output),
                new Test(new double[]{1,0,1,1}, new double[]{1}, output),
                new Test(new double[]{1,0,1,1}, new double[]{1}, output),
                new Test(new double[]{1,0,1,1}, new double[]{1}, output),
                new Test(new double[]{1,0,1,1}, new double[]{1}, output),
                new Test(new double[]{1,0,1,1}, new double[]{1}, output)
               };

int count = 500;

print(output[0].probe(double[]{1,0,1,1});

while(count--){
  for(int i = 0; i < tests.length; i++)
    tests[i].train();
}

print(output[0].probe(double[]{1,0,1,1});