class Factorial
{
  public static void main (String[] a)
  {
    System.out.println (new Fac().Fac (6));
  }
}

class Fac
{
  public int Fac (int num)
  {
    int r;
    Fac recfac;
    Fac nonrecfac;
    recfac = this;
    nonrecfac = this;
    return recfac.RecFac(num) - nonrecfac.NonRecFac (num);
  }

  public int RecFac(int num)
  {
    int num_aux;
    if (num < 1)
      num_aux = 1 ;
    else
      num_aux = num * (this.RecFac(num-1));
    return num_aux;
  }

  public int NonRecFac (int num)
  {
    int i;
    int fat;
    i = num;
    fat = 1;
    while (i > 0)
      {
	fat = fat * i;
	i = i - 1;
      }
    return fat;
  }
}
