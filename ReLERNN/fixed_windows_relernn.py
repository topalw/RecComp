{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "b6ee6d24",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "10\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "\n",
    "\n",
    "data_names = [\"sim_2_10k.PREDICT.TXT\", \"sim_2_100k.PREDICT.TXT\",\"sim_4_10k.PREDICT.TXT\",\"sim_4_100k.PREDICT.TXT\",\"sim_10_10k.PREDICT.TXT\",\"sim_10_100k.PREDICT.TXT\",\"sim_20_10k.PREDICT.TXT\",\"sim_20_100k.PREDICT.TXT\",\"sim_50_10k.PREDICT.TXT\",\"sim_50_100k.PREDICT.TXT\",]\n",
    "names = ['sim_4_10000_relernn', 'sim_4_100000_relernn', 'sim_8_10000_relernn', 'sim_8_100000_relernn', 'sim_20_10000_relernn', 'sim_20_100000_relernn', 'sim_40_10000_relernn', 'sim_40_100000_relernn', 'sim_100_10000_relernn', 'sim_100_100000_relernn']\n",
    "j = 0\n",
    "for i in data_names:\n",
    "\n",
    "    data = pd.read_csv(i, sep = '\\t', header = 0)\n",
    "\n",
    "    starting_point = 21700000\n",
    "    ending_point = 45700000\n",
    "    total_length = ending_point - starting_point\n",
    "    \n",
    "    def convert_dict_to_fixed_windows(data, window_size):\n",
    "        fixed_windows = []\n",
    "        total_windows = ( total_length // window_size) \n",
    "\n",
    "        for i in range(total_windows):\n",
    "            window_start =starting_point + i * window_size\n",
    "            window_end = window_start + window_size\n",
    "            rec_in_window = [(rec*(pos_2 - pos_1)) if pos_2 < window_end and pos_1 > window_start else (rec*(window_end - pos_1)) if pos_1 < window_end and pos_2 > window_end and pos_1 > window_start else (rec*(pos_2 - window_start)) if pos_1 < window_start and pos_2 > window_start and pos_2 < window_end else (rec*(window_end - window_start)) if pos_1 < window_start and pos_2 > window_end else 0 for pos_1, pos_2, rec in zip(data['start'], data['end'], data['recombRate'])]\n",
    "            \n",
    "            if rec_in_window:\n",
    "                avg_rec = sum(rec_in_window) / window_size\n",
    "                fixed_windows.append((window_start, window_end, avg_rec))\n",
    "            else:\n",
    "                fixed_windows.append((window_start, window_end, 0))\n",
    "\n",
    "        fixed_windows_df = pd.DataFrame(fixed_windows, columns=['start', 'end', 'rec'])     \n",
    "        return fixed_windows_df\n",
    "\n",
    "\n",
    "    window_size = 100000\n",
    "    \n",
    "    fixed_windows_df = convert_dict_to_fixed_windows(data, window_size)\n",
    "    fixed_windows_df.to_csv(f'{names[j]}.txt', sep = '\\t', index=False)\n",
    "    j += 1\n",
    "print(j)"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}