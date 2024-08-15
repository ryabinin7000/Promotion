namespace Promotion
{
    public class Champion
    {
        public int Code { get; set; }
        public string FIO { get; set; }
        public string Weight { get; set; }
        public string Date { get; set; }
        public Champion(int code, string fio, string weight, string date)
        {
            Code = code; FIO = fio; Weight = weight; Date = date;
        }
        public Champion() { }
    }
}
