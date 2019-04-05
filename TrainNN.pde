class Neyron {
  Neyron[] child = null;
  double[] weight;

  Neyron(Neyron[] child_, double[] weight_) {
    child = child_;
    weight = weight_;
  }

  Neyron(Neyron[] child_) {
    child = child_;
    weight = new double[child.length];
    for (int i = 0; i < weight.length; i++)
      weight[i] = random(1);
  }

  Neyron(int n_child, double[] weight_) {
    weight = weight_;
  }

  Neyron(int n_child) {
    weight = new double[n_child];
    for (int i = 0; i < weight.length; i++)
      weight[i] = random(1);
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
    return sum;
  }

  void train(double[] x, double correct, boolean isFirst) {
    if(isFirst){
      double out = this.probe(x);
      double delWeight = ()
    }
  }
}
