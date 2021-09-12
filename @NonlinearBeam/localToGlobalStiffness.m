function K = localToGlobalStiffness(this)
K = (this.R)'* this.k * this.R;
end