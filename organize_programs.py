#!/usr/bin/env python3
"""
각 번호 폴더에서 dictionary를 제외한 모든 폴더들을 program 폴더로 이동시킵니다.
"""
import os
import shutil
from pathlib import Path

def organize_programs(base_path):
    """각 번호 폴더에서 dictionary를 제외한 폴더들을 program 폴더로 이동"""
    base = Path(base_path)
    
    # 번호 폴더 찾기 (00, 01, 02, ...)
    number_folders = sorted([d for d in base.iterdir() if d.is_dir() and d.name.isdigit()])
    
    for num_folder in number_folders:
        print(f"\n처리 중: {num_folder.name}/")
        
        # program 폴더 생성
        program_folder = num_folder / "program"
        program_folder.mkdir(exist_ok=True)
        
        # dictionary를 제외한 모든 폴더 찾기
        folders_to_move = []
        for item in num_folder.iterdir():
            if item.is_dir() and item.name != "dictionary" and item.name != "program":
                folders_to_move.append(item)
        
        # 폴더들을 program 폴더로 이동
        for folder in folders_to_move:
            dest = program_folder / folder.name
            if dest.exists():
                print(f"  경고: {folder.name}은(는) 이미 program 폴더에 존재합니다. 건너뜁니다.")
            else:
                print(f"  이동: {folder.name} -> program/{folder.name}")
                shutil.move(str(folder), str(dest))
        
        if not folders_to_move:
            print(f"  이동할 폴더가 없습니다.")

if __name__ == "__main__":
    script_dir = Path(__file__).parent
    organize_programs(script_dir)
    print("\n완료되었습니다!")

