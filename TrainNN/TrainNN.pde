class Neyron {
  Neyron[] child = null;
  double[] weight;
  double learnRate = 0.01d;

  Neyron(Neyron[] child_, double[] weight_) {
    child = child_;
    weight = weight_;
  }

  Neyron(Neyron[] child_) {
    child = child_;
    weight = new double[child.length];
    for (int i = 0; i < weight.length; i++)
      weight[i] = random(0, 1);
  }

  Neyron(double[] weight_) {
    weight = weight_;
  }

  Neyron(int n_child) {
    weight = new double[n_child];
    for (int i = 0; i < weight.length; i++)
      weight[i] = random(0, 1);
  }

  double probe(double[] x) {
    double sum = 0;
    if (child == null) {
      for (int i = 0; i < x.length; i++) {
        double x_ = x[i];
        //print(weight);
        double w_ = weight[i];
        sum += x_ * w_;
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

  int train(double[] x, double correct, boolean isFirst) {
    double out = this.probe(x);
    double delWeight = correct;
    if (isFirst) {
      delWeight = (out - correct) * out * (1 - out);
    }
    if (child != null) {
      for (int i = 0; i < weight.length; i++) {
        weight[i] -= child[i].probe(x) * delWeight * learnRate;
        child[i].train(x, weight[i] * delWeight, false);
      }
    } else {
      for (int i = 0; i < weight.length; i++) {
        weight[i] -= x[i] * delWeight * learnRate;
      }
    }
    return (int)correct == (int)out ? 1 : 0;
  }
}

class Test {
  double[] input;
  double[] correct;
  Neyron[] output;
  Test(double[] input_, double[] correct_, Neyron[] output_) {
    input = input_;
    correct = correct_;
    output = output_;
  }

  int train() {
    int sum = 0;
    for (int i = 0; i < output.length; i++)
      sum += output[i].train(input, correct[i], true);
     return (int) (sum * 1.0 / output.length);
  }
}

Neyron[] hiddenLayer1 = {new Neyron(4), new Neyron(4), new Neyron(4)};
Neyron[] hiddenLayer2 = {new Neyron(hiddenLayer1), new Neyron(hiddenLayer1), new Neyron(hiddenLayer1)};
Neyron[] hiddenLayer3 = {new Neyron(hiddenLayer2), new Neyron(hiddenLayer2)};
Neyron[] output = {new Neyron(hiddenLayer3)};
Test[] tests = {
  new Test(new double[]{0, 0, 0, 0}, new double[]{0}, output),
  new Test(new double[]{0, 0, 0, 1}, new double[]{1}, output),
  new Test(new double[]{0, 0, 1, 0}, new double[]{1}, output),
  new Test(new double[]{0, 0, 1, 1}, new double[]{0}, output),
  new Test(new double[]{0, 1, 0, 0}, new double[]{0}, output),
  new Test(new double[]{0, 1, 0, 1}, new double[]{1}, output),
  new Test(new double[]{0, 1, 1, 0}, new double[]{1}, output),
  new Test(new double[]{0, 1, 1, 1}, new double[]{0}, output),
  new Test(new double[]{1, 0, 0, 0}, new double[]{0}, output),
  new Test(new double[]{1, 0, 0, 1}, new double[]{1}, output),
  new Test(new double[]{1, 0, 1, 0}, new double[]{1}, output),
  new Test(new double[]{1, 1, 0, 0}, new double[]{1}, output),
  new Test(new double[]{1, 1, 0, 1}, new double[]{0}, output),
  new Test(new double[]{1, 1, 1, 0}, new double[]{1}, output),
  new Test(new double[]{1, 1, 1, 1}, new double[]{0}, output)
};

int count = 500000;

double last = output[0].probe( new double[] {1, 0, 1, 1} );

tests[0].train();

while (count-- != 0) {
  for (int i = 0; i < tests.length; i++){
    tests[i].train();
  }
}
println(last);
println(output[0].probe( new double[] {1, 0, 1, 1} ));

for(int i = 0; i < tests.length; i++){
  println(output[0].probe(tests[i].input), " ", tests[i].correct[0]);
}
